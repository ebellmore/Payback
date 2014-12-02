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

@property (strong, nonatomic) IBOutlet UITextField *deltaAmount;
@property (strong, nonatomic) IBOutlet UILabel *currentDebt;
@property (weak, nonatomic) IBOutlet UIButton *giveButton;
@property (weak, nonatomic) IBOutlet UIButton *borrowButton;

@end

@implementation EditLedgerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.giveButton.layer.borderWidth = 1;
    self.giveButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.giveButton.layer.cornerRadius =5;
    self.giveButton.layer.masksToBounds = YES;
    
    self.borrowButton.layer.borderWidth = 1;
    self.borrowButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.borrowButton.layer.cornerRadius =5;
    self.borrowButton.layer.masksToBounds = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.title = self.holder[@"firstName"];
    self.currentDebt.text = [NSString stringWithFormat:@"Current: $%0.2f", [self.holder[@"total"] doubleValue]];
}

- (IBAction)givePressed:(id)sender {
    [self enterEmount:NO];
}

- (IBAction)borrowPressed:(id)sender {
    [self enterEmount:YES];
}

- (void) enterEmount:(BOOL)isDebt {
    
    double deltaAmount = [self.deltaAmount.text doubleValue];
    double prevAmount = [self.holder[@"total"] doubleValue];
    
    if(isDebt)
        deltaAmount *= -1;
    
    self.holder[@"total"] = @(prevAmount + deltaAmount);
    
    [self.holder saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];

}


@end
