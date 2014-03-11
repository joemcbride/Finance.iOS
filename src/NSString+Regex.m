//
//  NSString+Regex.m
//  Finance.iOS
//
//  Created by Joseph McBride on 3/3/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "NSString+Regex.h"

@implementation NSString (Regex)

+ (NSArray *) matches:(NSString *)data forPattern:(NSString *)pattern {
    
    if(data == nil || pattern == nil)
        return nil;
    
    NSError *error;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators
                                                                             error:&error];
    NSArray *matches = [regex matchesInString:data
                                      options:0
                                        range:NSMakeRange(0, [data length])];
    
    return matches;
}

+ (NSString *) match:(NSString *)data forPattern:(NSString *)pattern {
    
    if(data == nil || pattern == nil)
        return nil;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:data
                                                    options:0
                                                      range:NSMakeRange(0, [data length])];
    NSString *key = nil;
    
    if (match) {
        NSRange matchRange = [match rangeAtIndex:1];
        key = [data substringWithRange:matchRange];
    }
    return key;
}

@end
