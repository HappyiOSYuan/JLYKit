//
//  NSString+JLYDecimal.h
//  iShopManagement2.0
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 ningyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSString (JLYDecimal)
/*!
 *  @brief 字符串转化货币
 *
 *  @param inputString 需要转化的字符串
 *
 *  @return 转化后的货币字符串
 */
- (NSString *)moneyToString;
/*!
 *  @brief 银行卡号标准输出
 *
 *  @return 标准输出后的卡号
 */
- (NSString *)bankCard;

@end
NS_ASSUME_NONNULL_END