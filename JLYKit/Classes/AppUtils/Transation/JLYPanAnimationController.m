//
//  JLYPanAnimationController.m
//  TransitionsDemo
//
//  Created by Alvin Zeng on 01/08/2014.
//  Copyright (c) 2014 Alvin Zeng. All rights reserved.
//

#import "JLYPanAnimationController.h"
#import "viewControllerConfig.h"

@implementation JLYPanAnimationController

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
                   fromVC:(UIViewController *)fromVC
                     toVC:(UIViewController *)toVC
                 fromView:(UIView *)fromView
                   toView:(UIView *)toView {
    
    self.duration = 0.5;
    // Add the toView to the container
    UIView* containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    toView.frame = CGRectMake(self.reverse ? -screenWidth / 2 : screenWidth, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
    
    self.reverse ? [containerView sendSubviewToBack:toView] : [containerView bringSubviewToFront:toView];
    
    // animate
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromView.frame = CGRectMake(!self.reverse ? -screenWidth / 2 : screenWidth,
                                    fromView.frame.origin.y,
                                    fromView.frame.size.width,
                                    fromView.frame.size.height
                                    );
        toView.frame = CGRectMake(0,
                                  toView.frame.origin.y,
                                  toView.frame.size.width,
                                  toView.frame.size.height
                                  );
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            toView.frame = CGRectMake(0,
                                      toView.frame.origin.y,
                                      toView.frame.size.width,
                                      toView.frame.size.height
                                      );
            fromView.frame = CGRectMake(0,
                                        fromView.frame.origin.y,
                                        fromView.frame.size.width,
                                        fromView.frame.size.height
                                        );
        } else {
            // reset from- view to its original state
            [fromView removeFromSuperview];
            fromView.frame = CGRectMake(!self.reverse ? -screenWidth / 2 : screenWidth,
                                        fromView.frame.origin.y,
                                        fromView.frame.size.width,
                                        fromView.frame.size.height
                                        );
            toView.frame = CGRectMake(0,
                                      toView.frame.origin.y,
                                      toView.frame.size.width,
                                      toView.frame.size.height
                                      );
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

@end
