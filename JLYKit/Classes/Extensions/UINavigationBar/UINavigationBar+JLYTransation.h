//
//  UINavigationBar+Awesome.h
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UINavigationBar (JLYTransation)

- (void)jly_setBackgroundColor:(UIColor * _Nullable)backgroundColor;
- (void)jly_setElementsAlpha:(CGFloat)alpha;
- (void)jly_setTranslationY:(CGFloat)translationY;
- (void)jly_reset;

@end
NS_ASSUME_NONNULL_END