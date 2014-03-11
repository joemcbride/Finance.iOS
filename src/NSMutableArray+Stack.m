//
//  NSMutableArray+Stack.m
//  Finance.iOS
//
//  Created by Joseph McBride on 2/25/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "NSMutableArray+Stack.h"

@implementation NSMutableArray (Stack)

- (id)pop {
    id lastObject = [self lastObject];
    
    if(lastObject) {
        [self removeLastObject];
    }
    
    return lastObject;
}

- (void)push:(id)obj {
    [self addObject:obj];
}

@end
