//
//  UIButton+animation.h
//  iShopManageMent
//
//  Created by TJBT on 15/8/3.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIButton (animation)

@property(nonatomic, copy) CAAnimationGroup *animationGroup;

- (void)ndb_buttonAnimationWith:(UIColor *)highlightColor;

@end
NS_ASSUME_NONNULL_END