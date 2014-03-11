//
//  Transaction.m
//  Finance.iOS
//
//  Created by Joseph McBride on 2/26/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "Transaction.h"
#import "NSString+Date.h"
#import "NSString+Regex.h"
#import "Ono.h"

@implementation Transaction

+ (id)transactionWithElement:(ONOXMLElement *)element {
    return [[self alloc] initWithElement:element];
}

- (id)initWithElement:(ONOXMLElement *)element {
    self = [super init];
    if(!self) return nil;
    
    return self;
}

+ (id)transactionWithXml:(NSString *)xml {
    return [[self alloc] initWithXml:xml];
}

- (id)initWithXml:(NSString *)xml; {
    self = [super init];
    if(!self) return nil;
    
    self.memo = [NSString match:xml forPattern:@"<MEMO>(.+)</MEMO>"];
    self.name = [NSString match:xml forPattern:@"<NAME>(.+)</NAME>"];
    self.type = [NSString match:xml forPattern:@"<TRNTYPE>(.+)</TRNTYPE>"];
    self.externalId = [NSString match:xml forPattern:@"<FITID>(.+)</FITID>"];
    self.amount = [[NSString match:xml forPattern:@"<TRNAMT>(.+)</TRNAMT>"] floatValue];
    
    NSString *dateValue = [NSString match:xml forPattern:@"<DTPOSTED>(.+)</DTPOSTED>"];
    self.datePosted = [[dateValue substringToIndex:8] dateFromFormat:@"yyyyMMdd"];
    
    return self;
}

@end
