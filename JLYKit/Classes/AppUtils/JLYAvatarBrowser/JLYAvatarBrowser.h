//
//  JLYAvatarBrowser.h
//  iOrder2.0
//
//  Created by TJBT on 16/5/5.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface JLYAvatarBrowser : NSObject
/**
 *	@brief	浏览头像
 *
 *	@param 	oldImageView 	头像所在的imageView
 */
+ (void)showImage:(UIImageView*)avatarImageView;

@end
NS_ASSUME_NONNULL_END