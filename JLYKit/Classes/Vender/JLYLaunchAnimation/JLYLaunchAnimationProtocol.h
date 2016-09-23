//
//  JLYLaunchAnimationProtocol.h
//  JLYLaunchAnimationDemo
//
//  Created by ningyuan on 15/12/3.
//  Copyright © 2015年 ningyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JLYLaunchAnimationProtocol <NSObject>

- (void)configureAnimationWithView:(UIView *)view completion:(nullable void (^)(BOOL finished))completion;

@end
NS_ASSUME_NONNULL_END