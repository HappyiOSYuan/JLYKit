//
//  JLYLaunchFadeScaleAnimation.h
//  JLYLaunchAnimationDemo
//
//  Created by ningyuan on 15/12/3.
//  Copyright © 2015年 ningyuan. All rights reserved.
//

#import "JLYLaunchBaseAnimation.h"

NS_ASSUME_NONNULL_BEGIN
@interface JLYLaunchFadeScaleAnimation : JLYLaunchBaseAnimation

// super property
// duration default 0.6
// delay default 0.2
// options default UIViewAnimationCurveEaseOut

@property (nonatomic, assign) CGFloat scale;   // scale ratio default 1.6

+ (instancetype)fadeAnimation;

+ (instancetype)fadeScaleAnimation;// default

+ (instancetype)fadeAnimationWithDelay:(CGFloat)delay;

@end
NS_ASSUME_NONNULL_END