//
//  Transaction+Categories.h
//  Finance.iOS
//
//  Created by Joseph McBride on 3/17/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "Transaction.h"

@interface Transaction (Categories)

+ (Transaction *)newTransaction;
- (void)initWithXml:(NSString *)xml;

@end
