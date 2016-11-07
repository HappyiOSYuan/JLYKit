//
//  NSDate+JLYExtension.m
//  Pods
//
//  Created by mac on 16/9/19.
//
//

#import "NSDate+JLYExtension.h"

@implementation NSDate (JLYExtension)

- (NSUInteger)jly_day {
    return [NSDate jly_day:self];
}

- (NSUInteger)jly_month {
    return [NSDate jly_month:self];
}

- (NSUInteger)jly_year {
    return [NSDate jly_year:self];
}

- (NSUInteger)jly_hour {
    return [NSDate jly_hour:self];
}

- (NSUInteger)jly_minute {
    return [NSDate jly_minute:self];
}

- (NSUInteger)jly_second {
    return [NSDate jly_second:self];
}

+ (NSUInteger)jly_day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)jly_month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)jly_year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)jly_hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)jly_minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)jly_second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)jly_daysInYear {
    return [NSDate jly_daysInYear:self];
}

+ (NSUInteger)jly_daysInYear:(NSDate *)date {
    return [self jly_isLeapYear:date] ? 366 : 365;
}

- (BOOL)jly_isLeapYear {
    return [NSDate jly_isLeapYear:self];
}

+ (BOOL)jly_isLeapYear:(NSDate *)date {
    NSUInteger year = [date jly_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)jly_formatYMD {
    return [NSDate jly_formatYMD:self];
}

+ (NSString *)jly_formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%lu-%02lu-%02lu",[date jly_year],[date jly_month], [date jly_day]];
}

- (NSUInteger)jly_weeksOfMonth {
    return [NSDate jly_weeksOfMonth:self];
}

+ (NSUInteger)jly_weeksOfMonth:(NSDate *)date {
    return [[date jly_lastdayOfMonth] jly_weekOfYear] - [[date jly_begindayOfMonth] jly_weekOfYear] + 1;
}

- (NSUInteger)jly_weekOfYear {
    return [NSDate jly_weekOfYear:self];
}

+ (NSUInteger)jly_weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date jly_year];
    
    NSDate *lastdate = [date jly_lastdayOfMonth];
    
    for (i = 1;[[lastdate jly_dateAfterDay:-7 * i] jly_year] == year; i++) {
        
    }
    
    return i;
}

- (NSDate *)jly_dateAfterDay:(NSUInteger)day {
    return [NSDate jly_dateAfterDate:self day:day];
}

+ (NSDate *)jly_dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)jly_dateAfterMonth:(NSUInteger)month {
    return [NSDate jly_dateAfterDate:self month:month];
}

+ (NSDate *)jly_dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)jly_begindayOfMonth {
    return [NSDate jly_begindayOfMonth:self];
}

+ (NSDate *)jly_begindayOfMonth:(NSDate *)date {
    return [self jly_dateAfterDate:date day:-[date jly_day] + 1];
}

- (NSDate *)jly_lastdayOfMonth {
    return [NSDate jly_lastdayOfMonth:self];
}

+ (NSDate *)jly_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self jly_begindayOfMonth:date];
    return [[lastDate jly_dateAfterMonth:1] jly_dateAfterDay:-1];
}

- (NSUInteger)jly_daysAgo {
    return [NSDate jly_daysAgo:self];
}

+ (NSUInteger)jly_daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

- (NSInteger)jly_weekday {
    return [NSDate jly_weekday:self];
}

+ (NSInteger)jly_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)jly_dayFromWeekday {
    return [NSDate jly_dayFromWeekday:self];
}

+ (NSString *)jly_dayFromWeekday:(NSDate *)date {
    return [self jly_weekArray][[date jly_weekday]];
}

+ (NSArray<NSString *> *)jly_weekArray{
    return @[
             @"星期天" ,
             @"星期一" ,
             @"星期二" ,
             @"星期三" ,
             @"星期四" ,
             @"星期五" ,
             @"星期六"
             ];
}

- (BOOL)jly_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)jly_isToday {
    return [self jly_isSameDay:[NSDate date]];
}

- (NSDate *)jly_dateByAddingDays:(NSUInteger)days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

+ (NSString *)jly_monthWithMonthNumber:(NSInteger)month {
    if (0 == month) {
        return @"";
    }
    if (12 < month) {
        return @"";
    }
    return [self jly_monthArr][month];
}

+ (NSArray<NSString *> *)jly_monthArr{
    return @[
             @"January" ,
             @"February" ,
             @"March" ,
             @"April" ,
             @"May" ,
             @"June" ,
             @"July" ,
             @"August" ,
             @"September" ,
             @"October" ,
             @"November" ,
             @"December"
             ];
}

+ (NSString *)jly_stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date jly_stringWithFormat:format];
}

- (NSString *)jly_stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSDate *)jly_dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}

- (NSUInteger)jly_daysInMonth:(NSUInteger)month {
    return [NSDate jly_daysInMonth:self month:month];
}

+ (NSUInteger)jly_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date jly_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)jly_daysInMonth {
    return [NSDate jly_daysInMonth:self];
}

+ (NSUInteger)jly_daysInMonth:(NSDate *)date {
    return [self jly_daysInMonth:date month:[date jly_month]];
}

- (NSString *)jly_timeInfo {
    return [NSDate jly_timeInfoWithDate:self];
}

+ (NSString *)jly_timeInfoWithDate:(NSDate *)date {
    return [self jly_timeInfoWithDateString:[self jly_stringWithDate:date format:[self jly_ymdHmsFormat]]];
}

+ (NSString *)jly_timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self jly_dateWithString:dateString format:[self jly_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate jly_month] - [date jly_month]);
    int year = (int)([curDate jly_year] - [date jly_year]);
    int day = (int)([curDate jly_day] - [date jly_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate jly_month] == 1 && [date jly_month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self jly_daysInMonth:date month:[date jly_month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate jly_day] + (totalDays - (int)[date jly_day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate jly_month];
            int preMonth = (int)[date jly_month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

- (NSString *)jly_ymdFormat {
    return [NSDate jly_ymdFormat];
}

- (NSString *)jly_hmsFormat {
    return [NSDate jly_hmsFormat];
}

- (NSString *)jly_ymdHmsFormat {
    return [NSDate jly_ymdHmsFormat];
}

+ (NSString *)jly_ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)jly_hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)jly_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self jly_ymdFormat], [self jly_hmsFormat]];
}

- (NSDate *)jly_offsetYears:(int)numYears {
    return [NSDate jly_offsetYears:numYears fromDate:self];
}

+ (NSDate *)jly_offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)jly_offsetMonths:(int)numMonths {
    return [NSDate jly_offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)jly_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)jly_offsetDays:(int)numDays {
    return [NSDate jly_offsetDays:numDays fromDate:self];
}

+ (NSDate *)jly_offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)jly_offsetHours:(int)hours {
    return [NSDate jly_offsetHours:hours fromDate:self];
}

+ (NSDate *)jly_offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

@end
