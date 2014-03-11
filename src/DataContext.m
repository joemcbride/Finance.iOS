//
//  DataContext.m
//  Finance.iOS
//
//  Created by Joseph McBride on 2/26/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "DataContext.h"
#import "Account.h"
#import "TransactionCategory.h"
#import "OfxParser.h"

@implementation DataContext

- (NSArray *)accounts {
    NSArray *items = @[[Account accountWithName:@"Personal Checking"], [Account accountWithName:@"Visa"]];
    return items;
}

- (NSArray *)transactionsFor:(Account *)account {
    OfxParser *parser = [[OfxParser alloc] init];
    
    NSURL *url = [[NSBundle bundleForClass:self.class] URLForResource:@"sample" withExtension:@"ofx"];
    NSString *data = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    return [parser parseOfxTransactions:data];
}

- (NSArray *)categories {
    NSArray *categories = @[
                            [TransactionCategory categoryWithId:1 andName:@"Telecommunications"],
                            [TransactionCategory categoryWithId:2 andName:@"Accounting"],
                            [TransactionCategory categoryWithId:3 andName:@"Travel Meals"]
                            ];
    return categories;
}

@end
