//
//  NSDate+JLYExtension.h
//  Pods
//
//  Created by mac on 16/9/19.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSDate (JLYExtension)

/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)jly_day;
- (NSUInteger)jly_month;
- (NSUInteger)jly_year;
- (NSUInteger)jly_hour;
- (NSUInteger)jly_minute;
- (NSUInteger)jly_second;
+ (NSUInteger)jly_day:(NSDate *)date;
+ (NSUInteger)jly_month:(NSDate *)date;
+ (NSUInteger)jly_year:(NSDate *)date;
+ (NSUInteger)jly_hour:(NSDate *)date;
+ (NSUInteger)jly_minute:(NSDate *)date;
+ (NSUInteger)jly_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)jly_daysInYear;
+ (NSUInteger)jly_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)jly_isLeapYear;
+ (BOOL)jly_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)jly_weekOfYear;
+ (NSUInteger)jly_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)jly_formatYMD;
+ (NSString *)jly_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)jly_weeksOfMonth;
+ (NSUInteger)jly_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)jly_begindayOfMonth;
+ (NSDate *)jly_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)jly_lastdayOfMonth;
+ (NSDate *)jly_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)jly_dateAfterDay:(NSUInteger)day;
+ (NSDate *)jly_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)jly_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)jly_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)jly_offsetYears:(int)numYears;
+ (NSDate *)jly_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)jly_offsetMonths:(int)numMonths;
+ (NSDate *)jly_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)jly_offsetDays:(int)numDays;
+ (NSDate *)jly_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)jly_offsetHours:(int)hours;
+ (NSDate *)jly_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)jly_daysAgo;
+ (NSUInteger)jly_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)jly_weekday;
+ (NSInteger)jly_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)jly_dayFromWeekday;
+ (NSString *)jly_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)jly_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)jly_isToday;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)jly_dateByAddingDays:(NSUInteger)days;

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)jly_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)jly_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)jly_stringWithFormat:(NSString *)format;
+ (NSDate *)jly_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)jly_daysInMonth:(NSUInteger)month;
+ (NSUInteger)jly_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)jly_daysInMonth;
+ (NSUInteger)jly_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)jly_timeInfo;
+ (NSString *)jly_timeInfoWithDate:(NSDate *)date;
+ (NSString *)jly_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)jly_ymdFormat;
- (NSString *)jly_hmsFormat;
- (NSString *)jly_ymdHmsFormat;
+ (NSString *)jly_ymdFormat;
+ (NSString *)jly_hmsFormat;
+ (NSString *)jly_ymdHmsFormat;

@end
NS_ASSUME_NONNULL_END