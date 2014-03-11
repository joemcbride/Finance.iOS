//
//  OfxParser.h
//  Finance.iOS
//
//  Created by Joseph McBride on 2/25/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OfxParser : NSObject

- (NSArray *)parseOfxTransactions:(NSString *)data;

@end
