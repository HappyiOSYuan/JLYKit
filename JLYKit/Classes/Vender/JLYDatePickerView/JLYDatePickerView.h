//
//  JLYDatePickerView.h
//  CustomeSegmentControl
//
//  Created by 袁宁 on 2016/12/5.
//  Copyright © 2016年 zeluli. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface JLYDatePickerView : UIView

@property (nonatomic, strong, nullable) NSString *dateFormat;
@property (nonatomic, strong, nullable) UIColor *themeColor;
@property (nonatomic, strong, nullable) UIColor *titleColor;

@property (nonatomic, copy) void(^SelectDateBlock)(NSString *startTime,NSString *endTime);

- (void)show;
- (void)hide;

@end
NS_ASSUME_NONNULL_END
