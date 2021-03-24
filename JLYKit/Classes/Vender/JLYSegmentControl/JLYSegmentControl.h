//
//  JLYSegmentControl.h
//  CustomeSegmentControl
//
//  Created by 袁宁 on 2016/12/5.
//  Copyright © 2016年 zeluli. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef JLYSegmentControlInit
#define JLYSegmentControlInit ([[JLYSegmentControl alloc] init])
#endif

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickBlock)(NSInteger tag, NSString *title);

@interface JLYSegmentControl : UIView

@property (nonatomic, copy, readonly, nullable) JLYSegmentControl *(^SegmentTitles)(NSArray <NSString *>* titlesArr);
@property (nonatomic, copy, readonly, nullable) JLYSegmentControl *(^SegmentTitlesCustomColor)(UIColor *color);
@property (nonatomic, copy, readonly, nullable) JLYSegmentControl *(^SegmentTitlesHighlightColor)(UIColor *color);
@property (nonatomic, copy, readonly, nullable) JLYSegmentControl *(^SegmentBackgroundHighlightColor)(UIColor *color);
@property (nonatomic, copy, readonly, nullable) JLYSegmentControl *(^SegmentBorderHighlightColor)(UIColor *color);
@property (nonatomic, copy, readonly, nullable) JLYSegmentControl *(^SegmentTitlesFont)(UIFont *font);
@property (nonatomic, copy, readonly, nullable) JLYSegmentControl *(^SegmentClickBlock)(void(^)(NSInteger tag, NSString *title));

- (void)setSegmentSelectedIndex:(NSUInteger)index;

@end
NS_ASSUME_NONNULL_END
