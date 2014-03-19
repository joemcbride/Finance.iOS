//
//  DataContext.m
//  Finance.iOS
//
//  Created by Joseph McBride on 2/26/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "DataContext.h"
#import "Account.h"
#import "Account+Categories.h"
#import "TransactionCategory.h"
#import "OfxParser.h"
#import "AppDelegate.h"
#import "Transaction.h"

@implementation DataContext

- (NSArray *)accounts {
    MDMPersistenceController *coreData = [AppDelegate instance].persistenceController;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Account"];
    
    NSError *error;
    NSArray *results = [coreData.managedObjectContext executeFetchRequest:request error:&error];
    
    if(!results) {
        NSLog(@"Error fetching accounts: %@", error.localizedDescription);
    }
    
    return results;
}

- (NSArray *)transactionsFor:(Account *)account {
    
    MDMPersistenceController *coreData = [AppDelegate instance].persistenceController;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Transaction"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"datePosted" ascending:NO]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"account.accountId == %@", account.accountId];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *results = [coreData.managedObjectContext executeFetchRequest:request error:&error];
    
    if(!results) {
        NSLog(@"Error fetching transactions: %@", error.localizedDescription);
    }
    
    return results;
}

- (NSArray *)categories {
    NSArray *categories = @[
                            [TransactionCategory categoryWithId:1 andName:@"Telecommunications"],
                            [TransactionCategory categoryWithId:2 andName:@"Accounting"],
                            [TransactionCategory categoryWithId:3 andName:@"Travel Meals"]
                            ];
    return categories;
}

-(Account *)accountWithName:(NSString *)name andId:(NSNumber *)num {
    
    Account *acc = [Account newAccount];
    acc.accountId = num;
    acc.name = name;
    return acc;
}

- (NSArray *)import:(NSURL *)url for:(Account *)account {
    
    OfxParser *parser = [[OfxParser alloc] init];
    
    NSString *data = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *transactions = [parser parseOfxTransactions:data];
    
    [transactions enumerateObjectsUsingBlock:^(Transaction *trans, NSUInteger idx, BOOL *stop) {
        trans.account = account;
    }];
    
    return transactions;
}

@end
