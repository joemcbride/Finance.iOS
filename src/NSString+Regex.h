//
//  NSString+Regex.h
//  Finance.iOS
//
//  Created by Joseph McBride on 3/3/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regex)

+ (NSArray *) matches:(NSString *)data forPattern:(NSString *)pattern;
+ (NSString *) match:(NSString *)data forPattern:(NSString *)pattern;

@end
