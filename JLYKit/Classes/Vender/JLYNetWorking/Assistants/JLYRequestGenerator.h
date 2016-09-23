//
//  NDBRequestGenerator.h
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface JLYRequestGenerator : NSObject

+ (instancetype)sharedInstance;

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(nullable NSDictionary<NSString * ,id>*)requestParams
                                               methodName:(NSString * _Nonnull)methodName;
- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                             requestParams:(nullable NSDictionary<NSString * ,id>*)requestParams
                                                methodName:(NSString *)methodName;
- (NSURLRequest *)generateImageRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                              requestParams:(nullable NSDictionary<NSString * ,id>*)requestParams
                                                 methodName:(NSString *)methodName;
- (NSURLRequest *)generateRestfulGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                                   requestParams:(nullable NSDictionary<NSString * ,id>*)requestParams
                                                      methodName:(NSString *)methodName;
- (NSURLRequest *)generateRestfulPOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                                    requestParams:(nullable NSDictionary<NSString * ,id>*)requestParams
                                                       methodName:(NSString *)methodName;
- (NSURLRequest *)generateGoolgeMapAPIRequestWithParams:(nullable NSDictionary<NSString * ,id>*)requestParams
                                      serviceIdentifier:(NSString *)serviceIdentifier;

@end
NS_ASSUME_NONNULL_END