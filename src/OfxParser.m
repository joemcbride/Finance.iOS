//
//  OfxParser.m
//  Finance.iOS
//
//  Created by Joseph McBride on 2/25/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "OfxParser.h"
#import "SgmlReader.h"
#import "NSString+Regex.h"
#import "NSMutableArray+Stack.h"
#import "Ono.h"
#import "Transaction.h"

static inline BOOL isEmpty(id thing) {
    return thing == nil
    || [thing isKindOfClass:[NSNull class]]
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

@implementation OfxParser

- (NSArray *)parseOfxTransactions:(NSString *)data {
    NSString *xml = [self convertToXml:data];
    
    ONOXMLDocument *document = [ONOXMLDocument XMLDocumentWithData:[xml dataUsingEncoding:NSUTF8StringEncoding]
                                                             error:nil];
    
    NSMutableArray *transactions = [[NSMutableArray alloc] init];
    
    [document enumerateElementsWithXPath:@"//BANKMSGSRSV1/STMTTRNRS/STMTRS/BANKTRANLIST/STMTTRN"
                                   block:^(ONOXMLElement *element) {
        Transaction *trans = [Transaction transactionWithXml:[element description]];
        [transactions addObject:trans];
    }];
    
    return transactions;
}

- (NSString *)convertToXml:(NSString *)data {
    NSRange startOfx = [data rangeOfString:@"<OFX>"];
    if(startOfx.location == NSNotFound)
        return nil;
    
    NSString *ofx = [data substringFromIndex:startOfx.location];
    
    NSMutableString *result = [[NSMutableString alloc]init];
    NSMutableArray *stack = [[NSMutableArray alloc] init];
    __block NSString *previousElement = nil;
    
    SgmlReader *reader = [[SgmlReader alloc]init];
    
    [reader parse:ofx withAction:^(SgmlNodeType type, NSString *value) {
        switch (type) {
            case SgmlNodeTypeStartElement: {
                if(previousElement != nil && ![value isEqualToString:previousElement]){
                    [result appendString:@"\n"];
                }
                previousElement = value;
                [result appendFormat:@"<%@>", value];
                break;
            }
            case SgmlNodeTypeText: {
                NSString *trimmed = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if(!isEmpty(trimmed)){
                    [result appendFormat:@"%@", trimmed];
                    if(previousElement){
                        [result appendFormat:@"</%@>", previousElement];
                        [stack push:[NSString stringWithString:previousElement]];
                    }
                }
                break;
            }
            case SgmlNodeTypeEndElement: {
                if(stack.count > 0 && [value isEqualToString:previousElement]) {
                    [stack pop];
                } else {
                    [result appendFormat:@"\n</%@>", value];
                }
                break;
            }
        }
    }];
    
    return [NSString stringWithString:result];
}

@end
