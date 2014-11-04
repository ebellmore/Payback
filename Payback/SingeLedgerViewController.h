//
//  SingeLedgerViewController.h
//  Payback
//
//  Created by Evan Backup on 11/2/14.
//  Copyright (c) 2014 Evan Bellmore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingeLedgerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *ViewLedger;
@property (weak, nonatomic) IBOutlet UITextField *FirstName;
@property (weak, nonatomic) IBOutlet UITextField *LastName;
@property (weak, nonatomic) IBOutlet UITextField *Amount;
@property (weak, nonatomic) IBOutlet UIButton *AddToLedger;

@end
