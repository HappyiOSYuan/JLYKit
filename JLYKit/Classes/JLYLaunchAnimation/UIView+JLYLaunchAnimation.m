//
//  UIView+JLYLaunchAnimation.m
//  JLYLaunchAnimationDemo
//
//  Created by ningyuan on 15/12/3.
//  Copyright © 2015年 ningyuan. All rights reserved.
//

#import "UIView+JLYLaunchAnimation.h"

//current window
#define tyCurrentWindow [[UIApplication sharedApplication].windows firstObject]

@implementation UIView (JLYLaunchAnimation)

- (void)showInView:(UIView *)superView animation:(id<JLYLaunchAnimationProtocol>)animation completion:(void (^)(BOOL finished))completion{
    if (superView == nil) {
        NSLog(@"superView can't nil");
        return;
    }
    superView.hidden = NO;
    [superView addSubview:self];
    [superView bringSubviewToFront:self];
    
    self.frame = superView.bounds;
    
    if (animation && [animation respondsToSelector:@selector(configureAnimationWithView:completion:)]) {
        [animation configureAnimationWithView:self completion:completion];
    }else {
        completion(YES);
    }
}

- (void)showInWindowWithAnimation:(id<JLYLaunchAnimationProtocol>)animation completion:(void (^)(BOOL finished))completion{
    [self showInView:tyCurrentWindow animation:animation completion:completion];
}

@end
