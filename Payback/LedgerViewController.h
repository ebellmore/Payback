//
//  LedgerViewController.h
//  Payback
//
//  Created by Evan Backup on 11/2/14.
//  Copyright (c) 2014 Evan Bellmore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LedgerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *SingleLeadger;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@end
