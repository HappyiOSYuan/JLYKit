//
//  NSDictionary+JLYNetworkingMethods.h
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSDictionary (JLYNetworkingMethods)

- (NSString *)jly_urlParamsStringSignature:(BOOL)isForSignature;
- (NSString *)jly_jsonString;
- (NSArray<NSString *> *)jly_transformedUrlParamsArraySignature:(BOOL)isForSignature;

@end
NS_ASSUME_NONNULL_END