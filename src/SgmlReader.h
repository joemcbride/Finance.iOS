//
//  SgmlReader.h
//  Finance.iOS
//
//  Created by Joseph McBride on 2/25/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SgmlNodeType) {
    SgmlNodeTypeStartElement,
    SgmlNodeTypeText,
    SgmlNodeTypeEndElement
};

typedef void (^SgmlReaderAction)(SgmlNodeType type, NSString *value);

@interface SgmlReader : NSObject

- (void)parse:(NSString *)data withAction:(SgmlReaderAction)action;

@end
