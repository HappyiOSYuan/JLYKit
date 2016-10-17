//
//  NSString+JLY_CalculateSize.h
//  iOrder
//
//  Created by TJBT on 15/7/6.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSString (JLY_CalculateSize)
/*!
 *  @brief 字符串占位大小计算
 *
 *  @param size 最大尺寸
 *  @param font 字体
 *
 *  @return 占位大小
 */
- (CGSize)ndb_calculateSize:(CGSize)size font:(UIFont *)font;
- (NSString *)cutTimeString;

@end
NS_ASSUME_NONNULL_END