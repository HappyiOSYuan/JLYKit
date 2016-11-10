//
//  NSObject+DateString.h
//  iOrder2.0
//
//  Created by TJBT on 16/1/6.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+JLYExtension.h"

NS_ASSUME_NONNULL_BEGIN
@interface NSObject (DateString)
/*!
 *  @brief 根据自定义时间格式将long long型数据转化为时间字符串
 *
 *  @param time       时间数据
 *  @param dateFormat 时间格式
 *
 *  @return 转化后时间字符串
 */
- (NSString *)stringFromTime:(long long)time DateFormat:(NSString *)dateFormat;
/*!
 *  @brief 根据自定义时间格式将NSDate型数据转化为时间字符串
 *
 *  @param date       时间数据
 *  @param dateFormat 时间格式
 *
 *  @return 转化后时间字符串
 */
- (NSString *)stringFromDate:(NSDate *)date DateFormat:(NSString *)dateFormat;
/*!
 *  @brief 当天时间
 *
 *  @return 时间字符串
 */
- (NSString *)todayString;

/**
 当月第一天

 @return 当月第一天字符串
 */
- (NSString *)currentMonthBeginDay;

/**
 当月最后一天

 @return 当月最后一天字符串
 */
- (NSString *)currentMonthEndDay;

/**
 上月第一天

 @return 上月第一天字符串
 */
- (NSString *)lastMonthBeginDay;

/**
 上月最后一天

 @return 上月最后一天字符串
 */
- (NSString *)lastMonthEndDay;
/*!
 *  @brief 月末时间数据转化
 *
 *  @param date 月末时间NSDate类型数据
 *
 *  @return 时间字符串
 */
- (NSString *)monthEndDay:(NSDate *)date;
/*!
 *  @brief 月初时间数据转化
 *
 *  @param date 月初时间NSDate类型数据
 *
 *  @return 时间字符串
 */
- (NSString *)monthBeginDay:(NSDate *)date;
/*!
 *  @brief 当前月份
 *
 *  @return 时间字符串
 */
- (NSString *)currentMonth;
/*!
 *  @brief 相隔时间计算
 *
 *  @param time 时间数据
 *
 *  @return 相隔天数
 */
- (NSString *)calculateFromDate:(long long)time;

@end
NS_ASSUME_NONNULL_END
