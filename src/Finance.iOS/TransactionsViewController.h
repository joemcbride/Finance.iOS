//
//  TransactionsViewController.h
//  Finance.iOS
//
//  Created by Joseph McBride on 2/26/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Account.h"

@interface TransactionsViewController : UITableViewController

@property (nonatomic, strong) Account *account;

@end
