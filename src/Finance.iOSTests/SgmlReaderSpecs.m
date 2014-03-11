//
//  SgmlReaderSpecs.m
//  Finance.iOS
//
//  Created by Joseph McBride on 2/25/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

#import "SgmlReader.h"

SpecBegin(SgmlReaderSpecs)

describe(@"SgmlReader", ^{
    
    it(@"should parse non-closed tags", ^{
        SgmlReader *reader = [[SgmlReader alloc] init];
        
        [reader parse:@"<tag>a value" withAction:^(SgmlNodeType type, NSString *value) {
            switch(type){
                case SgmlNodeTypeStartElement: {
                    expect(value).to.equal(@"tag");
                    break;
                }
                case SgmlNodeTypeText: {
                    expect(value).to.equal(@"a value");
                    break;
                }
                case SgmlNodeTypeEndElement: {
                    NSAssert(false, @"Should not get end element notification.");
                    break;
                }
            }
        }];
    });
    
    it(@"should parse normal tags", ^{
        SgmlReader *reader = [[SgmlReader alloc] init];
        
        [reader parse:@"<tag>a value</tag>" withAction:^(SgmlNodeType type, NSString *value) {
            switch(type){
                case SgmlNodeTypeStartElement: {
                    expect(value).to.equal(@"tag");
                    break;
                }
                case SgmlNodeTypeText: {
                    expect(value).to.equal(@"a value");
                    break;
                }
                case SgmlNodeTypeEndElement: {
                    expect(value).to.equal(@"tag");
                    break;
                }
            }
        }];
    });
    
    it(@"should parse mixed tags", ^{
        SgmlReader *reader = [[SgmlReader alloc] init];
        
        NSMutableString *result = [[NSMutableString alloc]init];
        
        [reader parse:@"<root><tag>a value</root>" withAction:^(SgmlNodeType type, NSString *value) {
            switch(type){
                case SgmlNodeTypeStartElement: {
                    [result appendFormat:@"<%@>", value];
                    break;
                }
                case SgmlNodeTypeText: {
                    [result appendString:value];
                    break;
                }
                case SgmlNodeTypeEndElement: {
                    [result appendFormat:@"</%@>", value];
                    break;
                }
            }
        }];
        
        expect(result).to.equal(@"<root><tag>a value</root>");
    });
    
});

SpecEnd