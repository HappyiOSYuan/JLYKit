//
//  JLYMaterialTextFeild.m
//  JLYTextFeild
//
//  Created by TJBT on 16/6/2.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYMaterialTextFeild.h"
#import "JLYDottedLineLayer.h"

@implementation JLYMaterialTextFeild
#pragma mark - LifeCycle
- (void)layoutSubviews{
    [super layoutSubviews];
    if (!self.valid) {
        [self.errorLabel sizeToFit];
        self.errorLabel.frame = CGRectMake(
                                           0.0f,
                                           self.frame.size.height + self.errorLabel.frame.size.height / 2,
                                           MIN(self.errorLabel.frame.size.width, self.frame.size.width),
                                           self.errorLabel.frame.size.height
                                           );

        self.errorImageView.frame = CGRectMake(
                                               self.frame.size.width - self.errorImageView.image.size.width,
                                               self.errorLabel.frame.origin.y,
                                               self.errorImageView.image.size.width,
                                               self.errorImageView.image.size.height
                                               );
    }
}

- (void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    if (layer == self.layer) {
        [self computeLineColor];
        CGFloat h = (self.isFirstResponder || !self.valid) ? self.underlineHighlightedHeight : self.underlineNormalHeight;
        
        if (self.enabled) {
            self.underlineLayer.opacity = 1;
            self.underlineLayer.frame = CGRectMake(
                                                   0.0f,
                                                   self.frame.size.height - h,
                                                   self.frame.size.width,
                                                   h
                                                   );
            self.dottedLayer.opacity = 0;
        }else{
            self.underlineLayer.opacity = 0;
            self.underlineLayer.frame = CGRectMake(
                                                   0.0f,
                                                   0.0f,
                                                   self.frame.size.width,
                                                   self.frame.size.height
                                                   );
            self.dottedLayer.opacity = 1;
            [self.dottedLayer updateDottedLayerPathWthHeight:h];
        }
    }
}
#pragma mark - PrivateMethod
- (void)commonInit{
    [super commonInit];
    self.underlineNormalColor = self.tintColor;
    self.underlineNormalHeight = 1.0f;
    self.underlineHighlightedHeight = 2.0f;
    [self.layer addSublayer:self.underlineLayer];
    [self.layer addSublayer:self.dottedLayer];
    self.errorMessageFont = [UIFont systemFontOfSize:12.0f];
    [self setErrorColor:[UIColor colorWithRed:255.0f/255.0f green:58.0f/255.0f blue:49.0f/255.0f alpha:1.0f]];
    self.errorLabel.hidden = YES;
    [self addSubview:self.errorLabel];
    self.errorImageView.hidden = YES;
    [self addSubview:self.errorImageView];
}

- (void)computeLineColor{
    CGColorRef lineColor = self.underlineNormalColor.CGColor;
    if (self.valid) {
        if (self.isFirstResponder) {
            if (self.underlineHighlightedColor) {
                lineColor = self.underlineHighlightedColor.CGColor;
            }else{
                lineColor = self.tintColor.CGColor;
            }
        }
    }else{
        lineColor = [UIColor colorWithRed:255.0f/255.0f green:58.0f/255.0f blue:49.0f/255.0f alpha:1.0f].CGColor;
    }
    self.underlineLayer.backgroundColor = lineColor;
    self.dottedLayer.strokeColor = lineColor;
    [self layoutIfNeeded];
}
#pragma mark - SettersAndGetters
- (BOOL)valid{
    return [self.errorMessage length] > 0 ? NO : YES;
}

- (void)setErrorMessage:(NSString *)errorMessage{
    if (_errorMessage != errorMessage) {
        _errorMessage = errorMessage;
    }
    NSLog(@"errorMessage--->%@" ,errorMessage);
    self.errorLabel.text = errorMessage;
    self.errorLabel.hidden = self.valid;
    self.errorImageView.hidden = self.valid;
    self.clipsToBounds = self.valid;
    [self computeLineColor];
}

- (void)setErrorColor:(UIColor *)errorColor{
    self.errorLabel.textColor = errorColor;
}

- (void)setErrorMessageFont:(UIFont *)errorMessageFont{
    self.errorLabel.font = errorMessageFont;
}

- (UILabel *)errorLabel{
    if (!_errorLabel) {
        _errorLabel = [UILabel new];
    }
    return _errorLabel;
}

- (UIImageView *)errorImageView{
    if (!_errorImageView) {
        _errorImageView = [UIImageView new];
    }
    return _errorImageView;
}

- (CALayer *)underlineLayer{
    if (!_underlineLayer) {
        _underlineLayer = [CALayer layer];
    }
    return _underlineLayer;
}

- (JLYDottedLineLayer *)dottedLayer{
    if (!_dottedLayer) {
        _dottedLayer = [[JLYDottedLineLayer alloc] init];
    }
    return _dottedLayer;
}

@end
