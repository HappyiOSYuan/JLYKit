//
//  UITextView+JLYSelect.h
//  Pods
//
//  Created by mac on 16/9/19.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UITextView (JLYSelect)
/*!
 *  @brief 当前选中字符串范围
 *
 *  @return 范围
 */
- (NSRange)jly_selectedRange;
/*!
 *  @brief 选中所有文字
 */
- (void)jly_selectAllText;
/*!
 *  @brief 选中指定范围的文字
 *
 *  @param range 指定范围
 */
- (void)jly_setSelectedRange:(NSRange)range;
/*!
 *  @brief 计算textview输入情况下的字符数
 *
 *  @param text 输入的字符串
 *
 *  @return 字符数
 */
- (NSInteger)jly_getInputLengthWithText:(NSString *)text;

@end
NS_ASSUME_NONNULL_END