//
//  TransactionDetailsViewController.h
//  Finance.iOS
//
//  Created by Joseph McBride on 3/3/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"

@interface TransactionDetailsViewController : UIViewController

@property (nonatomic, strong) Transaction *transaction;

@end
