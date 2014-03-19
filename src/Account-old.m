//
//  Account.m
//  Finance.iOS
//
//  Created by Joseph McBride on 2/26/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "Account-old.h"

@implementation Account_Old

+(id)accountWithName:(NSString *)name {
    return [[self alloc]initWithName:name];
}

-(id)initWithName:(NSString *)name {
    self = [super init];
    if(!self) return nil;
    
    _name = name;
    
    return self;
}

@end
