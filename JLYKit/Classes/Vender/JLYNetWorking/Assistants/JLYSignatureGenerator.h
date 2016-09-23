//
//  NDBSignatureGenerator.h
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface JLYSignatureGenerator : NSObject

+ (NSString *)signGetWithSigParams:(NSDictionary<NSString * ,id> *)allParams
                        methodName:(NSString *)methodName
                        apiVersion:(NSString *)apiVersion
                        privateKey:(NSString *)privateKey
                         publicKey:(NSString *)publicKey;

+ (NSString *)signRestfulGetWithAllParams:(NSDictionary<NSString * ,id> *)allParams
                               methodName:(NSString *)methodName
                               apiVersion:(NSString *)apiVersion
                               privateKey:(NSString *)privateKey;

+ (NSString *)signPostWithApiParams:(NSDictionary<NSString * ,id> *)apiParams
                         privateKey:(NSString *)privateKey
                          publicKey:(NSString *)publicKey;

+ (NSString *)signRestfulPOSTWithApiParams:(id)apiParams
                              commonParams:(NSDictionary<NSString * ,id> *)commonParams
                                methodName:(NSString *)methodName
                                apiVersion:(NSString *)apiVersion
                                privateKey:(NSString *)privateKey;

@end
NS_ASSUME_NONNULL_END
