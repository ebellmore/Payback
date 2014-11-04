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

@interface LedgerViewController ()
@property (copy, nonatomic) NSArray *ledgers;
@property (copy,nonatomic) NSArray *pfObjects;


@end

@implementation LedgerViewController{
    
    NSArray *passLedger;
}

@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    //    testObject[@"foo"] = @"bar";
    //    [testObject saveInBackground];
    
    
    //PFObject testObject = Parse.Object.extend("TestObject");
    
    NSMutableArray *listOfAccounts =[[NSMutableArray alloc]init];
    
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"TestObject"];
    NSArray *resultList = [query2 findObjects];
    //    PFObject *result1 = [query2 getObjectWithId:@"ZY4LHycnbR"];
    //    PFObject *result2 = [query2 getObjectWithId:@"ZUraGcgwtu"];
    //    PFObject *result3 = [query2 getObjectWithId:@"zPX7qA8kPC"];
    //    PFObject *result4 = [query2 getObjectWithId:@"17zh1eTY2o"];
    for(int i=0; i < resultList.count; i++){
        PFObject *result = resultList[i];
        NSString *fname = result[@"firstName"];
        [listOfAccounts addObject:fname];
    }
    self.ledgers = listOfAccounts;
    self.pfObjects = resultList;
    UITableView *tableView = (id)[self.view viewWithTag:1];
    UIEdgeInsets contentInset = tableView.contentInset;
    contentInset.top = 20;
    [tableView setContentInset:contentInset];
    
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


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.ledgers count];
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
    
    PFObject *holder = self.pfObjects[indexPath.row];
    NSString *nameString = self.ledgers[indexPath.row];
    cell.name = nameString;
    cell.amount = [holder[@"amount"] doubleValue];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditLedgerViewController *destViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditLedger"];
    destViewController.fname = [_ledgers objectAtIndex:indexPath.row];
    destViewController.dbID = [_pfObjects objectAtIndex:indexPath.row];
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

@end
