//
//  SingeLedgerViewController.m
//  Payback
//
//  Created by Evan Backup on 11/2/14.
//  Copyright (c) 2014 Evan Bellmore. All rights reserved.
//

#import "SingeLedgerViewController.h"
#import <Parse/Parse.h>
@interface SingeLedgerViewController ()

@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation SingeLedgerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.addButton.layer.borderWidth = 1;
    self.addButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.addButton.layer.cornerRadius =5;
    self.addButton.layer.masksToBounds = YES;
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


- (IBAction)addToLedgerClicked:(id)sender {
   
    NSString *firstName = _FirstName.text;
    NSString *lastNAme = _LastName.text;
    NSString *amount = _Amount.text;
    
    NSMutableDictionary * myDictionary = [NSMutableDictionary dictionary];;
    [myDictionary setValue:firstName.description forKey:@"firstName"];
    
    PFObject *testObject = [PFObject objectWithClassName:@"Person"];
    testObject[@"owner"] = [PFUser currentUser];
    testObject[@"firstName"] = firstName;
    testObject[@"lastName"] = lastNAme;
    testObject[@"total"] = @([amount doubleValue]);
    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

@end
