//
//  NSObject+DateString.h
//  iOrder2.0
//
//  Created by TJBT on 16/1/6.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

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
/*!
 *  @brief 月初时间
 *
 *  @return 时间字符串
 */
- (NSString *)monthBeginDay;
/*!
 *  @brief 月末时间
 *
 *  @return 时间字符串
 */
- (NSString *)monthEndDay;
/*!
 *  @brief 月末时间数据转化
 *
 *  @param date 月末时间NSDate类型数据
 *
 *  @return 时间字符串
 */
- (NSString *)monthEndDay:(NSDate *)date;
/*!
 *  @brief 月末时间Date数据
 *
 *  @param date 时间数据
 *
 *  @return 时间NSDate类型数据
 */
- (NSDate *)monthEndDate:(NSDate *)date;
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
- (int)calculateFromDate:(long long)time;

@end
NS_ASSUME_NONNULL_END