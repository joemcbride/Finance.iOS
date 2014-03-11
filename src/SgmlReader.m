//
//  SgmlReader.m
//  Finance.iOS
//
//  Created by Joseph McBride on 2/25/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "SgmlReader.h"
#import "Parsekit.h"

@implementation SgmlReader

- (void)parse:(NSString *)data withAction:(SgmlReaderAction)action {
    PKTokenizer *t = [PKTokenizer tokenizerWithString:data];
    t.whitespaceState.reportsWhitespaceTokens = YES;
    
    PKToken *eof = [PKToken EOFToken];
    PKToken *tok = nil;
    BOOL inElement = NO;
    BOOL inEndTag = NO;
    NSMutableString *tagName = [[NSMutableString alloc]init];
    NSMutableString *current = [[NSMutableString alloc]init];
    
    while (eof != (tok = [t nextToken])) {
        
        // start of a tag
        if([@"<" isEqualToString:tok.stringValue]) {
            
            // if there is data, push it before tracking the new element
            if([current length] > 0){
                action(SgmlNodeTypeText, [NSString stringWithString:current]);
                [current setString:@""];
            }
            inElement = YES;
            [current appendString:tok.stringValue];
            continue;
        }
        
        if([@">" isEqualToString:tok.stringValue]){
            inElement = NO;
            [current appendString:tok.stringValue];
            
            if(!inEndTag){
                // end of start tag
                action(SgmlNodeTypeStartElement, [NSString stringWithString:tagName]);
            } else {
                action(SgmlNodeTypeEndElement, [NSString stringWithString:tagName]);
            }
            
            inEndTag = NO;
            [current setString:@""];
            [tagName setString:@""];
            continue;
        }
        
        if(inElement) {
            if(![@"/" isEqualToString:tok.stringValue]){
                // building the tag name
                [tagName appendString:tok.stringValue];
            }
            if([@"/" isEqualToString:tok.stringValue]) {
                inEndTag = YES;
            }
        }
        
        [current appendString:tok.stringValue];
    }
}

@end
