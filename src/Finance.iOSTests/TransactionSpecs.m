//
//  TransactionSpecs.m
//  Finance.iOS
//
//  Created by Joseph McBride on 2/26/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

#import "Transaction.h"
#import "NSString+Date.h"

SpecBegin(TransactionSpecs)

describe(@"Transaction", ^{
    it(@"can initialize with xml", ^{
        
        Transaction *trans = [Transaction transactionWithXml:@"<STMTTRN>"
                              @"<TRNTYPE>DEBIT</TRNTYPE>"
                              @"<DTPOSTED>20130102120000.000</DTPOSTED>"
                              @"<TRNAMT>-8.54</TRNAMT>"
                              @"<FITID>0001049</FITID>"
                              @"<NAME>name</NAME>"
                              @"<MEMO>memo</MEMO>"
                              @"</STMTTRN>"];
        
        expect(trans.memo).to.equal(@"memo");
        expect(trans.name).to.equal(@"name");
        expect(trans.type).to.equal(@"DEBIT");
        expect(trans.amount).to.equal(-8.54);
        expect(trans.externalId).to.equal(@"0001049");
        expect(trans.datePosted).to.equal([@"20130102" dateFromFormat:@"yyyyMMdd"]);
    });
});

SpecEnd