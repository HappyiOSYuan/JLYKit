//
//  JLYAppUtils.m
//  iOrder
//
//  Created by TJBT on 15/6/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYAppUtils.h"
#import "UIImage+colorImage.h"
#import "UINavigationBar+Awesome.h"

@implementation JLYAppUtils

+ (void)setNavigationBarStyleWithColor:(UIColor *)color{
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20.0f],NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] jly_setBackgroundColor:color];
    
}

+ (UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, 64.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

+(int)caculateDayByStartDate:(NSString *)s_date andEndDate:(NSString *)e_date{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2];
    static NSDateFormatter* dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    NSDate *fromDate;
    NSDate *toDate;
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:[dateFormatter dateFromString:s_date]];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:e_date];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:toDate toDate:fromDate options:0];
#else
    [gregorian rangeOfUnit:NSDayCalendarUnit startDate:&fromDate interval:NULL forDate:[dateFormatter dateFromString:s_date]];
    [gregorian rangeOfUnit:NSDayCalendarUnit startDate:&toDate interval:NULL forDate:e_date];
    NSDateComponents *dayComponents = [gregorian components:NSDayCalendarUnit fromDate:toDate toDate:fromDate options:0];
#endif

    return @(dayComponents.day).intValue;
}

+ (NSString *)caculateDayByDate:(NSString *)date{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSCalendar *gregorian = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    [gregorian setFirstWeekday:2];
    static NSDateFormatter* dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    NSDate *fromDate;
    NSDate *toDate;
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:[dateFormatter dateFromString:date]];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:[NSDate date]];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:toDate toDate:fromDate options:0];
#else
    [gregorian rangeOfUnit:NSDayCalendarUnit startDate:&fromDate interval:NULL forDate:[dateFormatter dateFromString:date]];
    [gregorian rangeOfUnit:NSDayCalendarUnit startDate:&toDate interval:NULL forDate:[NSDate date]];
    NSDateComponents *dayComponents = [gregorian components:NSDayCalendarUnit fromDate:toDate toDate:fromDate options:0];
#endif
    return @(dayComponents.day).stringValue;
}


@end
