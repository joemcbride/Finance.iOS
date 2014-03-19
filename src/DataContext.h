//
//  DataContext.h
//  Finance.iOS
//
//  Created by Joseph McBride on 2/26/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface DataContext : NSObject

- (NSArray *)accounts;
- (NSArray *)transactionsFor:(Account *)account;
- (NSArray *)categories;
- (NSArray *)import:(NSURL *)url for:(Account *)account;

@end
