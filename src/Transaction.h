//
//  Transaction.h
//  Finance.iOS
//
//  Created by Joseph McBride on 3/17/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Transaction : NSManagedObject

@property (nonatomic, retain) NSNumber * transactionId;
@property (nonatomic, retain) NSNumber * categoryId;
@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSString * memo;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSDate * datePosted;
@property (nonatomic, retain) NSString * externalId;
@property (nonatomic, retain) NSManagedObject *account;

@end
