//
//  UIButton+center.h
//  MinderEduManager
//
//  Created by TJBT on 16/6/20.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIButton (center)
/*!
 *  @brief 设置按钮图片和文字居中
 *
 *  @param space 图片和文字间隔
 */
- (void)jly_centerImageAndTitle:(float)space;
/*!
 *  @brief 设置按钮图片和问题居中，默认间隔6
 */
- (void)jly_centerImageAndTitle;

@end
NS_ASSUME_NONNULL_END