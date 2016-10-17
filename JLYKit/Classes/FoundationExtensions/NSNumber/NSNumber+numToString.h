//
//  NSNumber+numToString.h
//  MinderEduManager
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSNumber (numToString)
/*!
 *  @brief 有效一位小数数字
 *
 *  @return 数字字符串
 */
- (NSString *)oneDecimalNumToString;
/*!
 *  @brief 有效两位小数数字显示
 *
 *  @return 数字字符串
 */
- (NSString *)twoDecimalNumToString;
/*!
 *  @brief 银行卡号
 *
 *  @return 银行卡号字符串
 */
- (NSString *)numToBankCard;
/*!
 *  @brief 字符串转化货币
 *
 *  @return 转化后的货币字符串
 */
- (NSString *)moneyToString;

@end
NS_ASSUME_NONNULL_END