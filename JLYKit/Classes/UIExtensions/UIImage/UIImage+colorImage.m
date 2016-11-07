//
//  UIImage+colorImage.m
//  iOrder
//
//  Created by TJBT on 15/6/18.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "UIImage+colorImage.h"

@implementation UIImage (colorImage)

- (UIImage *)jly_imageWithColor:(UIColor *)color{
    NSAssert(color != nil, @"颜色不能为空");
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)jly_imageWithColor:(UIColor *)color{
    NSAssert(color != nil, @"颜色不能为空");
    UIImage *newImage = [[UIImage alloc] init];
    [newImage jly_imageWithColor:color];
    return newImage;
}

@end
