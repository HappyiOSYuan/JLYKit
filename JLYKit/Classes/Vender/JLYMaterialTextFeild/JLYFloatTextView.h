//
//  JLYFloatLabeledTextView.h
//  JLYFloatLabeledTextField
//
//  Created by TJBT on 16/6/2.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface JLYFloatTextView : UITextView

@property (nonatomic, copy) IBInspectable NSString * placeholder;

@property (nonatomic, strong, readonly) UILabel * placeholderLabel;

@property (nonatomic, strong, readonly) UILabel * floatingLabel;

@property (nonatomic) IBInspectable CGFloat floatingLabelYPadding;

@property (nonatomic) IBInspectable CGFloat floatingLabelXPadding;

@property (nonatomic) IBInspectable CGFloat placeholderYPadding;

@property (nonatomic, strong) UIFont * floatingLabelFont;

@property (nonatomic, strong) IBInspectable UIColor * floatingLabelTextColor;

@property (nonatomic, strong) IBInspectable UIColor * floatingLabelActiveTextColor;

@property (nonatomic, assign) IBInspectable BOOL floatingLabelShouldLockToTop;

@property (nonatomic, strong) IBInspectable UIColor * placeholderTextColor;

@property (nonatomic, assign) IBInspectable BOOL animateEvenIfNotFirstResponder;

@property (nonatomic, assign) NSTimeInterval floatingLabelShowAnimationDuration UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) NSTimeInterval floatingLabelHideAnimationDuration UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) BOOL alwaysShowFloatingLabel;

- (void)commonInit;
- (void)setPlaceholder:(NSString *)placeholder floatingTitle:(NSString *)floatingTitle;

@end
NS_ASSUME_NONNULL_END