//
//  UIImage+JLYLaunchImage.h
//  JLYLaunchAnimationDemo
//
//  Created by ningyuan on 15/12/3.
//  Copyright © 2015年 ningyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JLYLaunchImage)

NS_ASSUME_NONNULL_BEGIN
+ (NSString *)jly_getLaunchImageName;

+ (UIImage *)jly_getLaunchImage;

@end
NS_ASSUME_NONNULL_END