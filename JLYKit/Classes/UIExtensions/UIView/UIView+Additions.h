//
//  UIView+Additions.h
//  iShopManageMent
//
//  Created by TJBT on 15/8/26.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIView (Additions)

@property (nonatomic, copy, readonly, nullable) __kindof UIView *(^viewFrame)(CGFloat x, CGFloat y, CGFloat width, CGFloat height);
@property (nonatomic, copy, readonly, nullable) __kindof UIView *(^viewLayer)(CGFloat radius, UIColor *color, CGFloat width);
@property (nonatomic, copy, readonly, nullable) __kindof UIView *(^viewHidden)(BOOL hidden);
@property (nonatomic, copy, readonly, nullable) __kindof UIView *(^viewUserEnabled)(BOOL enabled);
@property (nonatomic, copy, readonly, nullable) __kindof UIView *(^viewCenter)(CGFloat x, CGFloat y);

- (__kindof UIViewController * _Nullable)jly_viewController;

@end
NS_ASSUME_NONNULL_END
