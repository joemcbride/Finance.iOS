//
//  TransactionCategory.m
//  Finance.iOS
//
//  Created by Joseph McBride on 3/7/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "TransactionCategory.h"

@implementation TransactionCategory

+ (id)categoryWithId:(NSInteger)categoryId andName:(NSString *)name {
    return [[self alloc] initWithId:categoryId andName:name];
}

- (id)initWithId:(NSInteger)categoryId andName:(NSString *)name {
    self = [super init];
    if(!self) return nil;
    
    _categoryId = categoryId;
    _name = name;
    
    return self;
}
@end
