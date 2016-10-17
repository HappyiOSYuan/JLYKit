//
//  UIView+JLYLaunchAnimation.h
//  JLYLaunchAnimationDemo
//
//  Created by ningyuan on 15/12/3.
//  Copyright © 2015年 ningyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLYLaunchAnimationProtocol.h"

NS_ASSUME_NONNULL_BEGIN
@interface UIView (JLYLaunchAnimation)

- (void)showInWindowWithAnimation:(id<JLYLaunchAnimationProtocol>)animation completion:(nullable void (^)(BOOL finished))completion;

- (void)showInView:(UIView *)superView animation:(id<JLYLaunchAnimationProtocol>)animation completion:(nullable void (^)(BOOL finished))completion;

@end
NS_ASSUME_NONNULL_END