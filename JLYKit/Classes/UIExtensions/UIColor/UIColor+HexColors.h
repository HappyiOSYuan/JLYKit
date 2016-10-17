//
//  UIColor+HexColors.h
//  iShopManageMent
//
//  Created by TJBT on 15/11/26.
//  Copyright © 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
#import <UIKit/UIKit.h>
#define JLYColor UIColor
#else
#import <Cocoa/Cocoa.h>
#define HXColor NSColor
#endif

NS_ASSUME_NONNULL_BEGIN
@interface UIColor (HexColors)

+ (JLYColor *)ndb_colorWithHexString:(NSString *)hexString;
+ (JLYColor *)ndb_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (JLYColor *)ndb_colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;
+ (JLYColor *)ndb_colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;

@end
NS_ASSUME_NONNULL_END