//
//  JLYMaterialTextFeild.h
//  JLYTextFeild
//
//  Created by TJBT on 16/6/2.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYFloatTextField.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JLYDottedLineLayer;
@interface JLYMaterialTextFeild : JLYFloatTextField

@property (nonatomic ,assign) BOOL valid;
@property (nonatomic, copy) NSString *errorMessage;
@property (nonatomic, strong) CALayer *underlineLayer;
@property (nonatomic, strong) JLYDottedLineLayer *dottedLayer;
@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) UIImageView *errorImageView;
@property (nonatomic, strong) UIColor *underlineNormalColor;
@property (nonatomic, strong) UIColor *underlineHighlightedColor;
@property (nonatomic, assign) CGFloat underlineNormalHeight;
@property (nonatomic, assign) CGFloat underlineHighlightedHeight;
@property (nonatomic, strong) UIFont *errorMessageFont;
@property (nonatomic, strong) UIColor *errorColor;

@end
NS_ASSUME_NONNULL_END