//
//  NSString+Path.h
//  iOrder
//
//  Created by TJBT on 15/12/21.
//  Copyright © 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSObject (Path)
/*!
 *  @brief 设置图片路径
 *
 *  @return 图片路径
 */
- (NSString *)getPath;
/*!
 *  @brief 设置图面名字格式
 *
 *  @return 图片名称
 */
- (NSString *)imageName;
/*!
 *  @brief 图片完整路径
 *
 *  @return 路径
 */
- (NSString *)imageFullPath;

@end
NS_ASSUME_NONNULL_END