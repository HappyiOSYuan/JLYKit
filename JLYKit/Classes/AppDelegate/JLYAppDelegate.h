//
//  JLYAppDelegate.h
//  GenericFramework
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLYAppServiceManager.h"
#import <Reachability/Reachability.h>

NS_ASSUME_NONNULL_BEGIN
@interface JLYAppDelegate : UIResponder<UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) Reachability *reach;

/**
 监听网络状态
 */
- (void)startNetWorkListen;

@end
NS_ASSUME_NONNULL_END
