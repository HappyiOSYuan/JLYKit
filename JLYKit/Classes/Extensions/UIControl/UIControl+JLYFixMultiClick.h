//
//  UIControl+JLYFixMultiClick.h
//  Pods
//
//  Created by mac on 16/9/14.
//
//

#import <UIKit/UIKit.h>
/*!
 *  @brief 防止连点，1秒间隔
 */

NS_ASSUME_NONNULL_BEGIN
@interface UIControl (JLYFixMultiClick)

@property (nonatomic, assign) NSTimeInterval cs_acceptEventTime;

@end
NS_ASSUME_NONNULL_END