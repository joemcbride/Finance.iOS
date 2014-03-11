//
//  TransactionCategory.h
//  Finance.iOS
//
//  Created by Joseph McBride on 3/7/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionCategory : NSObject

@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, strong) NSString *name;

+ (id)categoryWithId:(NSInteger)categoryId andName:(NSString *)name;
- (id)initWithId:(NSInteger)categoryId andName:(NSString *)name;

@end
