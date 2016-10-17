//
//  NSObject+JsonString.h
//  iOrder2.0
//
//  Created by TJBT on 16/1/5.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSObject (JsonString)
/*!
 *  @brief 去掉json数据中的空格 换行字符
 *
 *  @param object 被转化json数据
 *
 *  @return 转化后json数据
 */
- (NSString *)ObjectTojsonString:(NSString *)object;

@end
NS_ASSUME_NONNULL_END