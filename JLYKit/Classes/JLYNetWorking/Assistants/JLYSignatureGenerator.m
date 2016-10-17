//
//  NDBSignatureGenerator.m
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYSignatureGenerator.h"
#import "JLYCommonParamsGenerator.h"
#import "NSDictionary+JLYNetworkingMethods.h"
#import "NSString+JLYNetworkingMethods.h"
#import "NSArray+JLYNetworkingMethods.h"

@implementation JLYSignatureGenerator

#pragma mark - public methods
+ (NSString *)signGetWithSigParams:(NSDictionary<NSString * ,id> *)allParams
                        methodName:(NSString *)methodName
                        apiVersion:(NSString *)apiVersion
                        privateKey:(NSString *)privateKey
                         publicKey:(NSString *)publicKey{
    return @"signature";
}

+ (NSString *)signRestfulGetWithAllParams:(NSDictionary<NSString * ,id> *)allParams
                               methodName:(NSString *)methodName
                               apiVersion:(NSString *)apiVersion
                               privateKey:(NSString *)privateKey{
    return @"signature";
}

+ (NSString *)signPostWithApiParams:(NSDictionary<NSString * ,id> *)apiParams
                         privateKey:(NSString *)privateKey
                          publicKey:(NSString *)publicKey{
    return @"signature";
}

+ (NSString *)signRestfulPOSTWithApiParams:(id)apiParams
                              commonParams:(NSDictionary<NSString * ,id> *)commonParams
                                methodName:(NSString *)methodName
                                apiVersion:(NSString *)apiVersion
                                privateKey:(NSString *)privateKey{
    return @"signature";
}


@end
