//
//  JLYBaseRouter.m
//  iShopManagement2.0
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 ningyuan. All rights reserved.
//

#import "JLYBaseRouter.h"
#import "JLYAppDelegate+Method.h"

@implementation JLYBaseRouter

- (JLYBaseNavigationController *)rootNav{
    return (JLYBaseNavigationController *)[JLYAppDelegate appDelegate].window.rootViewController;
}

@end
