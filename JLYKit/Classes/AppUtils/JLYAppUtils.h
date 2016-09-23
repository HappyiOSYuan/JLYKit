//
//  JLYAppUtils.h
//  iOrder
//
//  Created by TJBT on 15/6/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface JLYAppUtils : NSObject

+ (void)setNavigationBarStyle;
+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (int)caculateDayByStartDate:(NSString *)s_date andEndDate:(NSString *)e_date;
+ (NSString *)caculateDayByDate:(NSString *)date;

@end
NS_ASSUME_NONNULL_END