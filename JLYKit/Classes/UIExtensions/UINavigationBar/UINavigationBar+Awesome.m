//
//  UINavigationBar+Awesome.m
//  UINavigationBar
//
//  Created by tjbt on 16-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import "UINavigationBar+Awesome.h"
#import <objc/runtime.h>

@implementation UINavigationBar (Awesome)

static char overlayKey;

- (UIView *)overlay{
    UIView *view = objc_getAssociatedObject(self, &overlayKey);
    if (!view) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        view = [[UIView alloc] init];
        view.userInteractionEnabled = NO;
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight`
        view.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20.0f);
        [[self.subviews firstObject] insertSubview:view atIndex:0];
    }
    return view;
}

- (void)setOverlay:(UIView *)overlay{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)jly_setBackgroundColor:(UIColor *)backgroundColor{
    self.overlay.backgroundColor = backgroundColor;
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
    [self jly_resetWithColor:nil];
}

- (void)jly_resetWithColor:(UIColor *)backgroundColor{
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    if (backgroundColor) {
        self.overlay.backgroundColor = backgroundColor;
        self.overlay.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.bounds), 64.0f);
    }else{
        [self.overlay removeFromSuperview];
        self.overlay = nil;
    }
}

@end
