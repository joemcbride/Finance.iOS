//
//  Transaction.h
//  Finance.iOS
//
//  Created by Joseph McBride on 2/26/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ono.h"

@interface Transaction : NSObject

@property (nonatomic, copy) NSString *externalId;
@property (nonatomic, strong) NSDate *datePosted;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *memo;
@property (nonatomic, assign) float amount;
@property (nonatomic, assign) NSInteger categoryId;

+ (id)transactionWithElement:(ONOXMLElement *)element;
- (id)initWithElement:(ONOXMLElement *)element;

- (id)initWithXml:(NSString *)xml;
+ (id)transactionWithXml:(NSString *)xml;

@end
