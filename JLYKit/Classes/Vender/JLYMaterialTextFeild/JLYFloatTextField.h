//
//  JLYFloatTextField.h
//  JLYFloatTextField
//
//  Created by TJBT on 16/6/2.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface JLYFloatTextField : UITextField

@property (nonatomic, strong, readonly) UILabel * floatingLabel;

@property (nonatomic) IBInspectable CGFloat floatingLabelYPadding;

@property (nonatomic) IBInspectable CGFloat floatingLabelXPadding;

@property (nonatomic) IBInspectable CGFloat placeholderYPadding;

@property (nonatomic, strong) UIFont * floatingLabelFont;

@property (nonatomic, strong) IBInspectable UIColor * floatingLabelTextColor;

@property (nonatomic, strong) IBInspectable UIColor * floatingLabelActiveTextColor;

@property (nonatomic, assign) IBInspectable BOOL animateEvenIfNotFirstResponder;

@property (nonatomic, assign) NSTimeInterval floatingLabelShowAnimationDuration;

@property (nonatomic, assign) NSTimeInterval floatingLabelHideAnimationDuration;

@property (nonatomic, assign) IBInspectable BOOL adjustsClearButtonRect;

@property (nonatomic, assign) IBInspectable BOOL keepBaseline;

@property (nonatomic, assign) BOOL alwaysShowFloatingLabel;


- (void)setPlaceholder:(NSString *)placeholder floatingTitle:(NSString *)floatingTitle;
- (void)commonInit;

@end
NS_ASSUME_NONNULL_END