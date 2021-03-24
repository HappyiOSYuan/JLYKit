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

- (__kindof NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                                     requestParams:(nullable id)requestParams
                                                        methodName:(NSString *)methodName;
- (__kindof NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                                      requestParams:(nullable id)requestParams
                                                         methodName:(NSString *)methodName;
- (__kindof NSURLRequest *)generateFileRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                                       requestParams:(nullable id)requestParams
                                                          methodName:(NSString *)methodName;
- (__kindof NSURLRequest *)generateRestfulGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                                            requestParams:(nullable id)requestParams
                                                               methodName:(NSString *)methodName;
- (__kindof NSURLRequest *)generateRestfulPOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                                             requestParams:(nullable id)requestParams
                                                                methodName:(NSString *)methodName;
- (__kindof NSURLRequest *)generateGoolgeMapAPIRequestWithParams:(nullable id)requestParams
                                               serviceIdentifier:(NSString *)serviceIdentifier;

@end
NS_ASSUME_NONNULL_END
