//
//  UIColor+HexColors.m
//  iShopManageMent
//
//  Created by TJBT on 15/11/26.
//  Copyright © 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "UIColor+HexColors.h"

@implementation UIColor (HexColors)

+ (JLYColor *)ndb_colorWithHexString:(NSString *)hexString{
    // Check for hash and add the missing hash
    if('#' != [hexString characterAtIndex:0]){
        hexString = [NSString stringWithFormat:@"#%@", hexString];
    }
    
    CGFloat alpha = 1.0;
    if (5 == hexString.length || 9 == hexString.length) {
        NSString * alphaHex = [hexString substringWithRange:NSMakeRange(1, 9 == hexString.length ? 2 : 1)];
        if (1 == alphaHex.length) alphaHex = [NSString stringWithFormat:@"%@%@", alphaHex, alphaHex];
        hexString = [NSString stringWithFormat:@"#%@", [hexString substringFromIndex:9 == hexString.length ? 3 : 2]];
        unsigned alpha_u = [[self class] ndb_hexValueToUnsigned:alphaHex];
        alpha = ((CGFloat) alpha_u) / 255.0;
    }
    
    return [[self class] ndb_colorWithHexString:hexString alpha:alpha];
}

+ (JLYColor *)ndb_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha{
    if (hexString.length == 0) {
        return nil;
    }
    
    // Check for hash and add the missing hash
    if('#' != [hexString characterAtIndex:0]){
        hexString = [NSString stringWithFormat:@"#%@", hexString];
    }
    
    // check for string length
    if (7 != hexString.length && 4 != hexString.length) {
        NSString *defaultHex    = [NSString stringWithFormat:@"0xff"];
        unsigned defaultInt = [[self class] ndb_hexValueToUnsigned:defaultHex];
        
        JLYColor *color = [JLYColor ndb_colorWith8BitRed:defaultInt green:defaultInt blue:defaultInt alpha:1.0];
        return color;
    }
    
    // check for 3 character HexStrings
    hexString = [[self class] ndb_hexStringTransformFromThreeCharacters:hexString];
    
    NSString *redHex    = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(1, 2)]];
    unsigned redInt = [[self class] ndb_hexValueToUnsigned:redHex];
    
    NSString *greenHex  = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(3, 2)]];
    unsigned greenInt = [[self class] ndb_hexValueToUnsigned:greenHex];
    
    NSString *blueHex   = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(5, 2)]];
    unsigned blueInt = [[self class] ndb_hexValueToUnsigned:blueHex];
    
    JLYColor *color = [JLYColor ndb_colorWith8BitRed:redInt green:greenInt blue:blueInt alpha:alpha];
    
    return color;
}

+ (JLYColor *)ndb_colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue{
    return [[self class] ndb_colorWith8BitRed:red green:green blue:blue alpha:1.0];
}

+ (JLYColor *)ndb_colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha{
    JLYColor *color = nil;
#if (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)
    color = [JLYColor colorWithRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:alpha];
#else
    color = [JLYColor colorWithCalibratedRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:alpha];
#endif
    
    return color;
}

+ (NSString *)ndb_hexStringTransformFromThreeCharacters:(NSString *)hexString{
    if(hexString.length == 4){
        hexString = [NSString stringWithFormat:@"#%1$c%1$c%2$c%2$c%3$c%3$c",
                     [hexString characterAtIndex:1],
                     [hexString characterAtIndex:2],
                     [hexString characterAtIndex:3]];
        
    }
    
    return hexString;
}

+ (unsigned)ndb_hexValueToUnsigned:(NSString *)hexValue{
    unsigned value = 0;
    
    NSScanner *hexValueScanner = [NSScanner scannerWithString:hexValue];
    [hexValueScanner scanHexInt:&value];
    
    return value;
}

@end
