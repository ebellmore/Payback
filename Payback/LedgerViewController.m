//
//  LedgerViewController.m
//  Payback
//
//  Created by Evan Backup on 11/2/14.
//  Copyright (c) 2014 Evan Bellmore. All rights reserved.
//

#import "LedgerViewController.h"
#import <Parse/Parse.h>
#import "SingeLedgerViewController.h"
#import "EditLedgerViewController.h"
#import "CustomTableViewCell.h"
#import "LoginViewController.h"

@interface LedgerViewController ()

@property (copy,nonatomic) NSMutableArray *people;


@end

@implementation LedgerViewController{
    
    NSArray *passLedger;
}

@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.top = 20;
    [self.tableView setContentInset:contentInset];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    
    
    
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"Person"];
    [query2 whereKey:@"owner" equalTo:[PFUser currentUser]];
    [query2 findObjectsInBackgroundWithBlock:^(NSArray *resultList, NSError *error) {
        self.people = resultList;
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.people count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"LedgerCell";
    CustomTableViewCell *cell = (CustomTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:
                                                        SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
    }
    
    PFObject *holder = self.people[indexPath.row];
    cell.name = holder[@"firstName"];
    cell.amount = [holder[@"total"] doubleValue];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditLedgerViewController *destViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditLedger"];
//    destViewController.fname = [_ledgers objectAtIndex:indexPath.row];
//    destViewController.dbID = [_pfObjects objectAtIndex:indexPath.row];
    PFObject *holder = self.people[indexPath.row];
    destViewController.holder = holder;
    [self.navigationController pushViewController:destViewController animated:YES];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"editLedgerSegue"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        EditLedgerViewController *destViewController = segue.destinationViewController;
//        destViewController.fname = [_ledgers objectAtIndex:indexPath.row];
//        destViewController.dbID = [_pfObjects objectAtIndex:indexPath.row];
//    }
//}

//- (NSIndexPath *)tableView:(UITableView *)tableView
//  willSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//        return indexPath;
//
//}
//
//
//- (void)tableView:(UITableView *)tableView
//didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}


// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        
        PFObject *holder = self.people[indexPath.row];
        //self.people.count
        NSMutableArray *newList = [[NSMutableArray alloc] init];
        for(int i = 0; i< self.people.count;i++){
            if(self.people[i] != self.people[indexPath.row]) {
            [newList addObject:self.people[i]];
            }
        }
        [holder deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            
            [self.tableView reloadData];
        }];
        
        self.people = newList;
        [self.tableView reloadData];
        
    }
}






#pragma mark - Logout



-(void)showLogInPage{
    
PFLogInViewController *logInController = [[PFLogInViewController alloc] init];
logInController.delegate = self;
logInController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton | PFLogInFieldsSignUpButton | PFLogInFieldsFacebook;
PFSignUpViewController *signUpController = [[PFSignUpViewController alloc] init];
signUpController.delegate = self;
logInController.signUpController = signUpController;
[self presentViewController:logInController animated:YES completion:nil];
    //[self.navigationController setViewControllers:@[logInController]];
}

- (IBAction)logoutButtonClicked:(id)sender {
    [PFUser logOut];
    [self showLogInPage];
}








- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}


// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
    
    
    //[logInViewController setDelegate:self]; // Set ourselves as the delegate
    //
    //    // Create the sign up view controller
    //    PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
    //    [signUpViewController setDelegate:self]; // Set ourselves as the delegate
    //
    //    // Assign our sign up controller to be displayed from the login controller
    //    [logInViewController setSignUpController:signUpViewController];
    //
    //    // Present the log in view controller
    
    
    
    
    //    LedgerViewController *ledgerViewController = [[LedgerViewController alloc] init];
    
    //    [self presentViewController:ledgerViewController animated:YES completion:nil];
    
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}


// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissModalViewControllerAnimated:YES]; // Dismiss the PFSignUpViewController
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}







@end
