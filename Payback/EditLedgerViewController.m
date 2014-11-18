//
//  EditLedgerViewController.m
//  Payback
//
//  Created by Evan Backup on 11/3/14.
//  Copyright (c) 2014 Evan Bellmore. All rights reserved.
//

#import "EditLedgerViewController.h"
#import <Parse/Parse.h>
@interface EditLedgerViewController ()

@end

@implementation EditLedgerViewController
@synthesize fnameLabel;
@synthesize fname;
@synthesize dbID;

- (void)viewDidLoad {
    [super viewDidLoad];
    PFObject *holder = dbID;
    
    // Do any additional setup after loading the view.
    NSString *test = holder[@"firstName"];
    NSString *id = holder.objectId;
    
     fnameLabel.text = fname;
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
    
    PFObject *holder = dbID;
    [holder delete];
    
    NSString *firstName = _FirstName.text;
    NSString *lastNAme = _LastName.text;
    NSString *amount = _Amount.text;
    
    NSMutableDictionary * myDictionary = [NSMutableDictionary dictionary];;
    [myDictionary setValue:firstName.description forKey:@"firstName"];
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"firstName"] = firstName;
    testObject[@"lastName"] = lastNAme;
    testObject[@"amount"] = amount;
    [testObject saveInBackground];

}


@end
