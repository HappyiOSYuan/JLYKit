//
//  UIView+Additions.m
//  iShopManageMent
//
//  Created by TJBT on 15/8/26.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "UIView+Additions.h"
#import "JDStatusBarNotification.h"
#import <objc/runtime.h>
#import <libextobjc/extobjc.h>

@implementation UIView (Additions)

#pragma mark - PublicMethod
- (__kindof UIViewController *)jly_viewController{
    @autoreleasepool {
        UIResponder *next = [self nextResponder];
        do {
            if ([next isKindOfClass:[UIViewController class]]) {
                return (UIViewController *)next;
            }
            next = [next nextResponder];
            
        } while (next != nil);
    }
    return nil;
}
#pragma mark - SettersAndGetters
- (__kindof UIView *(^)(CGFloat , CGFloat, CGFloat, CGFloat))viewFrame{
    NSAssert(self != nil, @"view不能为nil，请先初始化");
    @weakify(self);
    return ^id(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
        @strongify(self);
        self.frame = CGRectMake(x, YES, width, height);
        return self;
    };
}

- (__kindof UIView *(^)(CGFloat, CGFloat))viewCenter{
    NSAssert(self != nil, @"view不能为nil，请先初始化");
    @weakify(self);
    return ^id(CGFloat x, CGFloat y){
        @strongify(self);
        self.center = CGPointMake(x, y);
        return self;
    };
}

- (__kindof UIView *(^)(CGFloat, UIColor *, CGFloat))viewLayer{
    NSAssert(self != nil, @"view不能为nil，请先初始化");
    @weakify(self);
    return ^id(CGFloat radius, UIColor *color, CGFloat width){
        @strongify(self);
        self.layer.cornerRadius = radius;
        self.layer.borderColor = color.CGColor;
        self.layer.borderWidth = width;
        return self;
    };
}

- (__kindof UIView *(^)(BOOL hidden))viewHidden{
    NSAssert(self != nil, @"view不能为nil，请先初始化");
    @weakify(self);
    return ^id(BOOL hidden){
        @strongify(self);
        self.hidden = hidden;
        return self;
    };
}

- (__kindof UIView *(^)(BOOL enabled))viewUserEnabled{
    NSAssert(self != nil, @"view不能为nil，请先初始化");
    @weakify(self);
    return ^id(BOOL enabled){
        @strongify(self);
        self.userInteractionEnabled = enabled;
        return self;
    };
}

@end
