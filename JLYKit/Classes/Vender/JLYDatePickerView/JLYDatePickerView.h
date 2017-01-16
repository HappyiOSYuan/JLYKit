//
//  JLYDatePickerView.h
//  CustomeSegmentControl
//
//  Created by 袁宁 on 2016/12/5.
//  Copyright © 2016年 zeluli. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef JLYDatePickerInit
#define JLYDatePickerInit ([[JLYDatePickerView alloc] init])
#endif

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectDateBlock)(NSString *startTime,NSString *endTime);

@interface JLYDatePickerView : UIView

@property (nonatomic, copy, readonly, nullable) JLYDatePickerView *(^DatePickerFormat)(NSString *format);
@property (nonatomic, copy, readonly) JLYDatePickerView *(^DatePickerTheme)(UIColor *color);
@property (nonatomic, copy, readonly) JLYDatePickerView *(^DatePickerTitleColor)(UIColor *color);
@property (nonatomic, copy, readonly) JLYDatePickerView *(^DatePickerSelectedBlock)(void(^)(NSString *startTime,NSString *endTime));

- (void)show;
- (void)hide;

@end
NS_ASSUME_NONNULL_END
