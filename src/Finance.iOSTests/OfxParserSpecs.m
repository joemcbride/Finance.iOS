//
//  OfxParserSpecs.m
//  Finance.iOS
//
//  Created by Joseph McBride on 2/26/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

#import "OfxParser.h"

SpecBegin(OfxParserSpecs)

describe(@"OfxParser", ^{

    it(@"should parse transactions", ^{
        
        NSURL *url = [[NSBundle bundleForClass:self.class] URLForResource:@"sample" withExtension:@"ofx"];
        NSString *ofxFile = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        
        OfxParser *parser = [[OfxParser alloc] init];
        NSArray *transactions = [parser parseOfxTransactions:ofxFile];
        
        expect(transactions.count).to.equal(2);
    });
});

SpecEnd