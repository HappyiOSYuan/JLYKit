//
//  NSData+imageWrite.h
//  iShopManageMent
//
//  Created by TJBT on 15/12/21.
//  Copyright © 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Path.h"

NS_ASSUME_NONNULL_BEGIN
@interface NSData (imageWrite)
/*!
 *  @brief 图片二级制数据写入文件
 */
- (void)imageWriteToFile;

@end
NS_ASSUME_NONNULL_END