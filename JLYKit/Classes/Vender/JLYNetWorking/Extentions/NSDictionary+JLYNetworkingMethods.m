//
//  NSDictionary+JLYNetworkingMethods.m
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "NSDictionary+JLYNetworkingMethods.h"
#import "NSArray+JLYNetworkingMethods.h"

@implementation NSDictionary (JLYNetworkingMethods)

/** 字符串前面是没有问号的，如果用于POST，那就不用加问号，如果用于GET，就要加个问号 */
- (NSString *)jly_urlParamsStringSignature:(BOOL)isForSignature{
    NSArray<NSString *> *sortedArray = [self jly_transformedUrlParamsArraySignature:isForSignature];
    return [sortedArray jly_paramsString];
}

/** 字典变json */
- (NSString *)jly_jsonString{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/** 转义参数 */
- (NSArray<NSString *> *)jly_transformedUrlParamsArraySignature:(BOOL)isForSignature{
    NSMutableArray<NSString *> *result = [[NSMutableArray alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![obj isKindOfClass:[NSString class]]) {
            obj = [NSString stringWithFormat:@"%@", obj];
        }
        if (!isForSignature) {
            obj = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,  (CFStringRef)obj,  NULL,  (CFStringRef)@"!*'();:@&;=+$,/?%#[]",  kCFStringEncodingUTF8));
        }
        if ([obj length] > 0) {
            [result addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
    NSArray<NSString *> *sortedResult = [result sortedArrayUsingSelector:@selector(compare:)];
    return sortedResult;
}


@end
