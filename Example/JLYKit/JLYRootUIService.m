//
//  JLYRootUIService.m
//  JLYKit
//
//  Created by 袁宁 on 2016/11/24.
//  Copyright © 2016年 HappyiOSYuan. All rights reserved.
//

#import "JLYRootUIService.h"
#import "viewControllerConfig.h"
#import "JLYRouter.h"

@implementation JLYRootUIService
JLY_EXPORT_SERVICE(rootUI)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    application.delegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    application.delegate.window.backgroundColor = [UIColor whiteColor];
    JLY_ShowRootWindow(JLYRouter, {
        [JLYAppUtils setNavigationBarStyleWithColor:themeColor(nil)];
    });
    [application.delegate.window makeKeyAndVisible];
    
    return YES;
}

@end
