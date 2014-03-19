//
//  AppDelegate.m
//  Finance.iOS
//
//  Created by Joseph McBride on 2/25/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "AppDelegate.h"
#import "AccountViewController.h"
#import "DataContext.h"

@implementation AppDelegate

+ (AppDelegate *)instance {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupCoreData];
    
    //[self import:@"sample" extension:@"ofx"];
    
    return YES;
}

- (NSString *)documentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

- (void)setupCoreData {
    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:@"Finance" withExtension:@"momd"];
    NSURL *storeUrl = [NSURL fileURLWithPath:[[self documentsDirectory] stringByAppendingPathComponent:@"finance.sqlite"]];
    
    NSLog(@"modelUrl: %@", modelUrl);
    NSLog(@"storeUrl: %@", storeUrl);
    
    self.persistenceController = [[MDMPersistenceController alloc] initWithStoreURL:storeUrl modelURL:modelUrl];
}

- (void)save {
    
    NSError *error;
    
    if([self.persistenceController.managedObjectContext save:&error]) {
        
        [self.persistenceController saveContextAndWait:YES completion:^(NSError *error) {
            if(error) {
                NSLog(@"ERROR: %@", error.localizedDescription);
            }
        }];
        
    } else {
        NSLog(@"Could not save: %@", error.localizedDescription);
    }
}

- (void)import:(NSString *)resource extension:(NSString *)extension {
    DataContext *context = [[DataContext alloc] init];
    NSArray *accounts = [context accounts];
    
    NSURL *url = [[NSBundle bundleForClass:self.class] URLForResource:resource withExtension:extension];
    
    NSArray *results = [context import:url for:[accounts firstObject]];
    if(results){
        [self save];
    }
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
