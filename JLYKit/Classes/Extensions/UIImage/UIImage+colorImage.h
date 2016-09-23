//
//  UIImage+colorImage.h
//  iOrder
//
//  Created by TJBT on 15/6/18.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIImage (colorImage)

+ (UIImage *)jly_imageWithColor:(UIColor *)color;
- (UIImage *)jly_imageWithColor:(UIColor *)color;

@end
NS_ASSUME_NONNULL_END