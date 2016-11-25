//
//  NSObject+DateString.m
//  iOrder2.0
//
//  Created by TJBT on 16/1/6.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "NSObject+DateString.h"

#define CurrentCalender [NSCalendar currentCalendar]
#define CalendarComponent [CurrentCalender components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate date]]

@implementation NSObject (DateString)

- (NSString *)stringFromTime:(long long)time DateFormat:(NSString *)dateFormat{
    return [NSDate jly_stringWithDate:[NSDate dateWithTimeIntervalSince1970:time / 1000] format:dateFormat];
}

- (NSString *)stringFromDate:(NSDate *)date DateFormat:(NSString *)dateFormat{
    return [NSDate jly_stringWithDate:date format:dateFormat];
}

- (NSString *)todayString{
    return [NSDate jly_stringWithDate:[NSDate date] format:[NSDate jly_ymdFormat]];
}

- (NSString *)currentMonthBeginDay{
    return [NSDate jly_stringWithDate:[NSDate jly_begindayOfMonth:[NSDate date]] format:[NSDate jly_ymdFormat]];
}

- (NSString *)currentMonthEndDay{
    return [self monthEndDay:[NSDate date]];
}

- (NSString *)lastMonthBeginDay{
    [CalendarComponent setMonth:([CalendarComponent month] - 1)];
    return [NSDate jly_stringWithDate:[NSDate jly_begindayOfMonth:[CurrentCalender dateFromComponents:CalendarComponent]] format:[NSDate jly_ymdFormat]];
}

- (NSString *)lastMonthEndDay{
    [CalendarComponent setMonth:([CalendarComponent month] - 1)];
    return [NSDate jly_stringWithDate:[NSDate jly_lastdayOfMonth:[CurrentCalender dateFromComponents:CalendarComponent]] format:[NSDate jly_ymdFormat]];
}

- (NSString *)monthBeginDay:(NSDate *)date{
    return [NSDate jly_stringWithDate:[NSDate jly_begindayOfMonth:date] format:[NSDate jly_ymdFormat]];
}

- (NSString *)monthEndDay:(NSDate *)date{
    return [NSDate jly_stringWithDate:[NSDate jly_lastdayOfMonth:date] format:[NSDate jly_ymdFormat]];
}

- (NSString *)calculateFromDate:(long long)time{
    return [NSDate jly_timeInfoWithDate:[NSDate dateWithTimeIntervalSince1970:time / 1000]];
}

- (NSString *)currentMonth{
    return [self stringFromDate:[NSDate date] DateFormat:@"YYYY年MM月"];
}

@end
