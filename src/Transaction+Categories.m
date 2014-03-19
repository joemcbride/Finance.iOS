//
//  Transaction+Categories.m
//  Finance.iOS
//
//  Created by Joseph McBride on 3/17/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "Transaction+Categories.h"
#import "AppDelegate.h"
#import "NSString+Date.h"
#import "NSString+Regex.h"

@implementation Transaction (Categories)

+(Transaction *)newTransaction {
    
    MDMPersistenceController *coreData = [AppDelegate instance].persistenceController;
    
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"Transaction"
                                            inManagedObjectContext:coreData.managedObjectContext];
    
    Transaction *acc = [[Transaction alloc] initWithEntity:desc
                    insertIntoManagedObjectContext:coreData.managedObjectContext];
    
    return acc;
}

- (void)initWithXml:(NSString *)xml {
    
    self.memo = [NSString match:xml forPattern:@"<MEMO>(.+)</MEMO>"];
    self.name = [NSString match:xml forPattern:@"<NAME>(.+)</NAME>"];
    self.type = [NSString match:xml forPattern:@"<TRNTYPE>(.+)</TRNTYPE>"];
    self.externalId = [NSString match:xml forPattern:@"<FITID>(.+)</FITID>"];
    
    float amount = [[NSString match:xml forPattern:@"<TRNAMT>(.+)</TRNAMT>"] floatValue];
    self.amount = [NSNumber numberWithFloat:amount];
    
    NSString *dateValue = [NSString match:xml forPattern:@"<DTPOSTED>(.+)</DTPOSTED>"];
    self.datePosted = [[dateValue substringToIndex:8] dateFromFormat:@"yyyyMMdd"];
}

@end
