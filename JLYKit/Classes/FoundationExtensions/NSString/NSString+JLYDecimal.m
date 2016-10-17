//
//  NSString+JLYDecimal.m
//  iShopManagement2.0
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 ningyuan. All rights reserved.
//

#import "NSString+JLYDecimal.h"

@implementation NSString (JLYDecimal)

- (NSString *)bankCard{
    return (16 == self.length) ? [self bankCard16] : [self bankCard19];
}

- (NSString *)bankCard16{
    static NSNumberFormatter *formatter = nil;
    if (!formatter) {
        formatter = [NSNumberFormatter new];
        [formatter setUsesGroupingSeparator:YES];
        [formatter setGroupingSize:4];
        [formatter setGroupingSeparator:@" "];
    }
    return [formatter stringForObjectValue:self];
}

- (NSString *)bankCard19{
    NSMutableString *card = [[NSMutableString alloc] initWithString:self];
    if (self.length > 16) {
        @autoreleasepool {
            for (int i = 0; i < self.length / 4; i++) {
                [card insertString:@" " atIndex:4 + i * 5];
            }
        }
    }
    return card;
}

- (NSString *)moneyToString{
    return [self notRounding:self afterPoint:2];
}

-(NSString *)notRounding:(NSString *)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                                      scale:position
                                                                                           raiseOnExactness:NO
                                                                                            raiseOnOverflow:NO
                                                                                           raiseOnUnderflow:NO
                                                                                        raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal = [NSDecimalNumber decimalNumberWithString:price];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}


@end
