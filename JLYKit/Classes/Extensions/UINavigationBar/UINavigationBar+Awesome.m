//
//  UINavigationBar+Awesome.m
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import "UINavigationBar+Awesome.h"
#import <objc/runtime.h>

@implementation UINavigationBar (Awesome)

- (void)jly_setBackgroundColor:(UIColor *)backgroundColor{
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self.subviews enumerateObjectsUsingBlock:^(UIView *viewObj ,NSUInteger idx ,BOOL *stop){
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_10_0
            NSString *classStr = [NSString stringWithUTF8String:object_getClassName(viewObj)];
            if ([classStr isEqualToString:@"_UIBarBackground"]) {
                UIImageView *imageView=(UIImageView *)viewObj;
                imageView.hidden=YES;
            }
#else
            NSString *classStr = [NSString stringWithUTF8String:object_getClassName(viewObj)];
            if ([classStr isEqualToString:@"_UINavigationBarBackground"]) {
                UIImageView *imageView=(UIImageView *)viewObj;
                imageView.hidden=YES;
            }
#endif
        }];
    }
    UIImageView *imageView = [self viewWithTag:111];
    if (!imageView) {
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0.0f, -20.0f, self.frame.size.width, 64.0f)];
        imageView.tag = 111;
        [imageView setBackgroundColor:backgroundColor];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self insertSubview:imageView atIndex:0];
        });
    }else{
        [imageView setBackgroundColor:backgroundColor];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self sendSubviewToBack:imageView];
        });
        
    }
}

- (void)jly_setTranslationY:(CGFloat)translationY{
    self.transform = CGAffineTransformMakeTranslation(0.0f, translationY);
}

- (void)jly_setElementsAlpha:(CGFloat)alpha{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
//    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)jly_reset{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

@end
