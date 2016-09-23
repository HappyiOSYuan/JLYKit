//
//  JLYCountDownButton.h
//  PayTreasure2.0
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface JLYCountDownButton : UIButton

/**
 *  1.设置秒数
 */
@property (nonatomic, assign) NSInteger second;

/**
 *  2.开始倒计时
 */
- (void)start;

/**
 *  3.结束倒计时
 */
- (void)stop;

@end
NS_ASSUME_NONNULL_END