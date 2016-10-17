//
//  UIButton+animation.m
//  iShopManageMent
//
//  Created by TJBT on 15/8/3.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "UIButton+animation.h"
#import <objc/runtime.h>

static char animationGroupKey = 'a';

@implementation UIButton (animation)

- (CAAnimationGroup *)animationGroup{
    return objc_getAssociatedObject(self, &animationGroupKey);
}

- (void)setAnimationGroup:(CAAnimationGroup *)animationGroup{
    objc_setAssociatedObject(self, &animationGroupKey, animationGroup, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)ndb_buttonAnimationWith:(UIColor *)highlightColor{
//    CALayer *l = [[CALayer alloc] init];
//    l.backgroundColor = highlightColor.CGColor;
//    l.bounds = CGRectMake(0, 0, 60.0f, 60.0f);
//    l.cornerRadius = 30.0f;
//    l.position = self.center;
//    [l addAnimation:self.animationGroup forKey:@"pulse"];
//    
//    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//    
//    l.animationGroup = [CAAnimationGroup animation];
//    self.animationGroup.duration = 3.0f;
//    self.animationGroup.repeatCount = 0;
//    self.animationGroup.removedOnCompletion = NO;
//    self.animationGroup.timingFunction = defaultCurve;
//    
//    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
//    scaleAnimation.fromValue = @0.0;
//    scaleAnimation.toValue = @1.0;
//    scaleAnimation.duration = 3.0f;
//    
//    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
//    opacityAnimation.duration = 3.0f;
//    opacityAnimation.values = @[@0.45, @0.45, @0];
//    opacityAnimation.keyTimes = @[@0, @0.2, @1];
//    opacityAnimation.removedOnCompletion = NO;
//    
//    NSArray *animations = @[scaleAnimation, opacityAnimation];
//    
//    self.animationGroup.animations = animations;
//    
//    [self.superview.layer insertSublayer:l below:self.layer];
}

@end
