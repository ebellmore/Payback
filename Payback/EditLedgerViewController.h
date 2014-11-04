//
//  EditLedgerViewController.h
//  Payback
//
//  Created by Evan Backup on 11/3/14.
//  Copyright (c) 2014 Evan Bellmore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditLedgerViewController : UIViewController
@property (nonatomic, strong) IBOutlet UILabel *fnameLabel;
@property (nonatomic, strong) NSString *fname;
@property (nonatomic, strong) NSObject *dbID;
@property (weak, nonatomic) IBOutlet UIButton *SubmitClicked;
@property (weak, nonatomic) IBOutlet UITextField *FirstName;
@property (weak, nonatomic) IBOutlet UITextField *LastName;
@property (weak, nonatomic) IBOutlet UITextField *Amount;



@end
