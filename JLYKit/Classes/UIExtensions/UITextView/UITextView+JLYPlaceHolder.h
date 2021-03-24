//
//  UITextView+JLYPlaceHolder.h
//  Pods
//
//  Created by mac on 16/9/19.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UITextView (JLYPlaceHolder)<UITextViewDelegate>
/*!
 *  @brief 提示文字视图
 */
@property (nonatomic, strong) UITextView *jly_placeHolderTextView;
/*!
 *  @brief 为UITextView添加placeholder视图
 *
 *  @param placeHolder 提示文字
 */
- (void)jly_addPlaceHolder:(NSString * _Nullable)placeHolder;

@end
NS_ASSUME_NONNULL_END