//
//  NSObject+JsonString.m
//  iOrder2.0
//
//  Created by TJBT on 16/1/5.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "NSObject+JsonString.h"

@implementation NSObject (JsonString)

- (NSString*)ObjectTojsonString:(NSString *)object{
    NSMutableString *mutStr = [NSMutableString stringWithString:object];
    NSRange range = {0,object.length};
    [mutStr replaceOccurrencesOfString:@" "  withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

@end
