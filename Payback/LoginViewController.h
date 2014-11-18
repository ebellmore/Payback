//
//  LoginViewController.h
//  Payback
//
//  Created by Evan Backup on 11/4/14.
//  Copyright (c) 2014 Evan Bellmore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface LoginViewController : UIViewController
<PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@end
