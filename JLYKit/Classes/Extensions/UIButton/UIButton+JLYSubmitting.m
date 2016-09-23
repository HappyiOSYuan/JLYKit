//
//  UIButton+JLYSubmitting.m
//  Pods
//
//  Created by mac on 16/9/19.
//
//

#import "UIButton+JLYSubmitting.h"
#import  <objc/runtime.h>

@interface UIButton ()

@property (nonatomic, strong) UIView *jly_modalView;
@property (nonatomic, strong) UIActivityIndicatorView *jly_spinnerView;
@property (nonatomic, strong) UILabel *jly_spinnerTitleLabel;

@end

@implementation UIButton (JLYSubmitting)

- (void)jly_beginSubmitting:(NSString *)title{
    [self jly_endSubmitting];
    
    self.jly_submitting = @YES;
    self.hidden = YES;
    
    self.jly_modalView = [[UIView alloc] initWithFrame:self.frame];
    self.jly_modalView.backgroundColor =
    [self.backgroundColor colorWithAlphaComponent:0.6];
    self.jly_modalView.layer.cornerRadius = self.layer.cornerRadius;
    self.jly_modalView.layer.borderWidth = self.layer.borderWidth;
    self.jly_modalView.layer.borderColor = self.layer.borderColor;
    
    CGRect viewBounds = self.jly_modalView.bounds;
    self.jly_spinnerView = [[UIActivityIndicatorView alloc]
                           initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.jly_spinnerView.tintColor = self.titleLabel.textColor;
    
    CGRect spinnerViewBounds = self.jly_spinnerView.bounds;
    self.jly_spinnerView.frame = CGRectMake(
                                           15, viewBounds.size.height / 2 - spinnerViewBounds.size.height / 2,
                                           spinnerViewBounds.size.width, spinnerViewBounds.size.height);
    self.jly_spinnerTitleLabel = [[UILabel alloc] initWithFrame:viewBounds];
    self.jly_spinnerTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.jly_spinnerTitleLabel.text = title;
    self.jly_spinnerTitleLabel.font = self.titleLabel.font;
    self.jly_spinnerTitleLabel.textColor = self.titleLabel.textColor;
    [self.jly_modalView addSubview:self.jly_spinnerView];
    [self.jly_modalView addSubview:self.jly_spinnerTitleLabel];
    [self.superview addSubview:self.jly_modalView];
    [self.jly_spinnerView startAnimating];
}

- (void)jly_endSubmitting{
    if (!self.isJLYSubmitting.boolValue) {
        return;
    }
    
    self.jly_submitting = @NO;
    self.hidden = NO;
    
    [self.jly_modalView removeFromSuperview];
    self.jly_modalView = nil;
    self.jly_spinnerView = nil;
    self.jly_spinnerTitleLabel = nil;
}

- (NSNumber *)isJLYSubmitting{
    return objc_getAssociatedObject(self, @selector(setJly_submitting:));
}

- (void)setJly_submitting:(NSNumber *)jly_submitting{
    objc_setAssociatedObject(self, @selector(setJly_submitting:), jly_submitting, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIActivityIndicatorView *)jly_spinnerView{
    return objc_getAssociatedObject(self, @selector(setJly_spinnerView:));
}

- (void)setJly_spinnerView:(UIActivityIndicatorView *)jly_spinnerView{
    objc_setAssociatedObject(self, @selector(setJly_spinnerView:), jly_spinnerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)jly_modalView{
    return objc_getAssociatedObject(self, @selector(setJly_modalView:));
}

- (void)setJly_modalView:(UIView *)jly_modalView{
    objc_setAssociatedObject(self, @selector(setJly_modalView:), jly_modalView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)jly_spinnerTitleLabel {
    return objc_getAssociatedObject(self, @selector(setJly_spinnerTitleLabel:));
}

- (void)setJly_spinnerTitleLabel:(UILabel *)jly_spinnerTitleLabel{
    objc_setAssociatedObject(self, @selector(setJly_spinnerTitleLabel:), jly_spinnerTitleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
