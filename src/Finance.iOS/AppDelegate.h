//
//  AppDelegate.h
//  Finance.iOS
//
//  Created by Joseph McBride on 2/25/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDMCoreData.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) MDMPersistenceController *persistenceController;

+ (AppDelegate *)instance;
- (void)save;

@end
