//
//  UIButton+JLYSubmitting.h
//  Pods
//
//  Created by mac on 16/9/19.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIButton (JLYSubmitting)
/*!
 *  @brief 按钮点击后，禁用按钮并在按钮上显示ActivityIndicator，以及title
 *
 *  @param title 按钮上显示的文字
 */
- (void)jly_beginSubmitting:(NSString *)title;
/*!
 *  @brief 点击按钮后恢复原来状态
 */
- (void)jly_endSubmitting;
/*!
 *  @brief 按钮是否正在提交中
 */
@property (nonatomic, readonly, getter = isJLYSubmitting) NSNumber *jly_submitting;

@end
NS_ASSUME_NONNULL_END