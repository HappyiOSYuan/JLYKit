//
//  NSObject+DateString.m
//  iOrder2.0
//
//  Created by TJBT on 16/1/6.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "NSObject+DateString.h"

@implementation NSObject (DateString)

- (NSString *)stringFromTime:(long long)time DateFormat:(NSString *)dateFormat{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time / 1000];
    return [self stringFromDate:date DateFormat:dateFormat];
}

- (NSString *)stringFromDate:(NSDate *)date DateFormat:(NSString *)dateFormat{
    static NSDateFormatter* formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale currentLocale]];
    }
    [formatter setDateFormat:dateFormat];
    return [formatter stringFromDate:date];
}

- (NSString *)todayString{
    return [self stringFromDate:[NSDate date] DateFormat:@"YYYY-MM-dd"];
}

- (NSString *)monthBeginDay{
    NSDate *now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *comps = [cal
                               components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                               fromDate:now];
#else
    NSDateComponents *comps = [cal
                               components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                               fromDate:now];
#endif
    
    comps.day = 1;
    NSDate *firstDay = [cal dateFromComponents:comps];
    return [self stringFromDate:firstDay DateFormat:@"YYYY-MM-dd"];
}

- (NSString *)monthEndDay{
    return [self monthEndDay:[NSDate date]];
}

- (NSString *)monthEndDay:(NSDate *)date{
    return [self stringFromDate:[self monthEndDate:date] DateFormat:@"YYYY-MM-dd"];
}

- (NSDate *)monthEndDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:date];
#else
    BOOL ok = [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:date];
#endif
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return [NSDate date];
    }
    return endDate;
}

- (int)calculateFromDate:(long long)time{
    NSDate *fromDate = [NSDate dateWithTimeIntervalSince1970:time / 1000];
    int nSecs = [[NSDate date] timeIntervalSince1970] - [fromDate timeIntervalSince1970];
    int oneDaySecs = 24*3600;
    return nSecs / oneDaySecs;
}

- (NSString *)currentMonth{
    return [self stringFromDate:[NSDate date] DateFormat:@"YYYY年MM月"];
}

@end
