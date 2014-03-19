//
//  Account+Categories.m
//  Finance.iOS
//
//  Created by Joseph McBride on 3/17/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "Account+Categories.h"
#import "AppDelegate.h"
#import "MDMCoreData.h"

@implementation Account (Categories)

+(Account *)newAccount {
    
    MDMPersistenceController *coreData = [AppDelegate instance].persistenceController;
    
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"Account"
                                            inManagedObjectContext:coreData.managedObjectContext];
    
    Account *acc = [[Account alloc] initWithEntity:desc
                    insertIntoManagedObjectContext:coreData.managedObjectContext];
    
    return acc;
}

@end
