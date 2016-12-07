//
//  JLYSegmentControl.h
//  CustomeSegmentControl
//
//  Created by 袁宁 on 2016/12/5.
//  Copyright © 2016年 zeluli. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickBlock)(NSInteger tag, NSString *title);

@interface JLYSegmentControl : UIView

@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong, nullable) UIColor *titlesCustomColor;
@property (nonatomic, strong, nullable) UIColor *titlesHighlightColor;
@property (nonatomic, strong, nullable) UIColor *backgroundHighlightColor;
@property (nonatomic, strong, nullable) UIFont *titlesFont;
@property (nonatomic, assign) CGFloat duration;

- (void)setButtonOnClickBlock:(ClickBlock)clickBlock;
- (void)setSegmentSelectedIndex:(NSUInteger)index;

@end
NS_ASSUME_NONNULL_END
