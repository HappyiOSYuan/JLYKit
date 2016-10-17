//
//  JLYLaunchBaseAnimation.h
//  JLYLaunchAnimationDemo
//
//  Created by ningyuan on 15/12/4.
//  Copyright © 2015年 ningyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JLYLaunchAnimationProtocol.h"

NS_ASSUME_NONNULL_BEGIN
@interface JLYLaunchBaseAnimation : NSObject<JLYLaunchAnimationProtocol>

@property (nonatomic, assign) CGFloat duration;// duration time
@property (nonatomic, assign) CGFloat delay;   // delay hide
@property (nonatomic, assign) UIViewAnimationOptions options;

@end
NS_ASSUME_NONNULL_END