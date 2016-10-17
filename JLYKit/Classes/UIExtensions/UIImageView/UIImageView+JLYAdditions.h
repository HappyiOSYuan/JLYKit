//
//  UIImageView+JLYAdditions.h
//  Pods
//
//  Created by mac on 16/9/19.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIImageView (JLYAdditions)
/*!
 *  @brief 创建imageview动画
 *
 *  @param imageArray 图片名称数组
 *  @param duration   动画时间
 *
 *  @return 动画
 */
+ (id)jly_imageViewWithImageArray:(NSArray<NSString *> *)imageArray duration:(NSTimeInterval)duration;

@end
NS_ASSUME_NONNULL_END