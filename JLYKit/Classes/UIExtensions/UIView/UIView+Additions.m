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

@implementation UIView (Additions)

- (UIViewController *)jly_viewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = [next nextResponder];
        
    } while (next != nil);
    return nil;
}

@end
