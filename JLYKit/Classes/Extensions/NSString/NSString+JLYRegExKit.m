//
//  NSString+JLYRegExKit.m
//  PayTreasure2.0
//
//  Created by TJBT on 16/3/18.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "NSString+JLYRegExKit.h"

#define phoneRegEx @"^1[3|4|5|7|8][0-9]\\d{8}$"
#define twoDecimalNum @"^[0-9]+(.[0-9]{1,2})?$"
#define oneDecimalNum @"^[0-9]+(.[0-9]{0,1})?$"
#define numRegEx @"^\\d+$"

@implementation NSString (JLYRegExKit)

- (BOOL)regExPhone{
    return [self regExWithFormat:phoneRegEx];
}

- (BOOL)regTwoDecimalNum{
    return [self regExWithFormat:twoDecimalNum];
}

- (BOOL)regExWithFormat:(NSString *)format{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",format] evaluateWithObject:self];
}

- (BOOL)regOneDecimaNum{
    return [self regExWithFormat:oneDecimalNum];
}

- (BOOL)regExNum{
    return [self regExWithFormat:numRegEx];
}

@end
