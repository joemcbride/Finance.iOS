//
//  Account.h
//  Finance.iOS
//
//  Created by Joseph McBride on 2/26/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

@property (nonatomic, copy) NSString *name;

+(id)accountWithName:(NSString *)name;
-(id)initWithName:(NSString *)name;

@end
