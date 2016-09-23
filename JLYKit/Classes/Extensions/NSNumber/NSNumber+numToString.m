//
//  NSNumber+numToString.m
//  MinderEduManager
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "NSNumber+numToString.h"

@implementation NSNumber (numToString)

- (NSString *)oneDecimalNumToString{
    static NSNumberFormatter *formatter = nil;
    if (!formatter) {
        formatter = [NSNumberFormatter new];
        [formatter setGroupingSeparator:@","];
        [formatter setGroupingSize:3];
        [formatter setUsesGroupingSeparator:YES];
        [formatter setDecimalSeparator:@"."];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:1];
    }

    return [formatter stringFromNumber:self];
}

- (NSString *)twoDecimalNumToString{
    static NSNumberFormatter *formatter = nil;
    if (!formatter) {
        formatter = [NSNumberFormatter new];
        [formatter setGroupingSeparator:@","];
        [formatter setGroupingSize:3];
        [formatter setUsesGroupingSeparator:YES];
        [formatter setDecimalSeparator:@"."];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:2];
    }
    
    return [formatter stringFromNumber:self];
}

- (NSString *)numToBankCard{
    return (16 == self.stringValue.length) ? [self bankCard16] : [self bankCard19];
}

- (NSString *)bankCard16{
    static NSNumberFormatter *formatter = nil;
    if (!formatter) {
        formatter = [NSNumberFormatter new];
        [formatter setUsesGroupingSeparator:YES];
        [formatter setGroupingSize:4];
        [formatter setGroupingSeparator:@" "];
    }
    return [formatter stringFromNumber:self];
}

- (NSString *)bankCard19{
    NSMutableString *card = [[NSMutableString alloc] initWithString:self.stringValue];
    if (self.stringValue.length > 16) {
        @autoreleasepool {
            for (int i = 0; i < self.stringValue.length / 4; i++) {
                [card insertString:@" " atIndex:4 + i * 5];
            }
        }
    }
    return card;
}

- (NSString *)moneyToString{
    return [self notRounding:self.stringValue afterPoint:2];
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
