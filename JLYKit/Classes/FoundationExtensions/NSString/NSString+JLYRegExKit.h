//
//  NSString+JLYRegExKit.h
//  PayTreasure2.0
//
//  Created by TJBT on 16/3/18.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSString (JLYRegExKit)
/*!
 *  @brief 正则判断手机号是否合法
 *
 *  @return 是否合法
 */
- (BOOL)regExPhone;
/*!
 *  @brief 正则判断有效两位小数是否合法
 *
 *  @return 是否合法
 */
- (BOOL)regTwoDecimalNum;
/*!
 *  @brief 正则判断有效一位小数是否合法
 *
 *  @return 是否合法
 */
- (BOOL)regOneDecimaNum;
/*!
 *  @brief 正则判断有效整数是否合法
 *
 *  @return 是否合法
 */
- (BOOL)regExNum;

@end
NS_ASSUME_NONNULL_END