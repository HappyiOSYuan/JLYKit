//
//  JLYAppDelegate.m
//  JLYKit
//
//  Created by HappyiOSYuan on 09/23/2016.
//  Copyright (c) 2016 HappyiOSYuan. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if ([super respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
        [super application:application didFinishLaunchingWithOptions:launchOptions];
        [self startNetWorkListen];
    }
    return YES;
}

@end
