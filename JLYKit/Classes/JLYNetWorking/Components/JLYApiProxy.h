//
//  NDBApiProxy.h
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JLYURLResponse.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^NDBCallback)(JLYURLResponse *response);

@interface JLYApiProxy : NSObject

+ (instancetype)sharedInstance;

- (NSInteger)callGETWithParams:(id _Nullable)params
             serviceIdentifier:(NSString *)servieIdentifier
                    methodName:(NSString *)methodName
                       success:(nullable NDBCallback)success
                          fail:(nullable NDBCallback)fail;

- (NSInteger)callPOSTWithParams:(id _Nullable)params
              serviceIdentifier:(NSString *)servieIdentifier
                     methodName:(NSString *)methodName
                        success:(nullable NDBCallback)success
                           fail:(nullable NDBCallback)fail;

- (NSInteger)callImageWithParams:(id _Nullable)params
               serviceIdentifier:(NSString *)servieIdentifier
                      methodName:(NSString *)methodName
                         success:(nullable NDBCallback)success
                            fail:(nullable NDBCallback)fail;

- (NSInteger)callRestfulGETWithParams:(id _Nullable)params
                    serviceIdentifier:(NSString *)servieIdentifier
                           methodName:(NSString *)methodName
                              success:(nullable NDBCallback)success
                                 fail:(nullable NDBCallback)fail;

- (NSInteger)callRestfulPOSTWithParams:(id _Nullable)params
                     serviceIdentifier:(NSString *)servieIdentifier
                            methodName:(NSString *)methodName
                               success:(nullable NDBCallback)success
                                  fail:(nullable NDBCallback)fail;

- (NSInteger)callGoogleMapAPIWithParams:(id _Nullable)params
                      serviceIdentifier:(NSString *)serviceIdentifier
                                success:(nullable NDBCallback)success
                                   fail:(nullable NDBCallback)fail;

- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray<NSNumber *> *)requestIDList;

@end
NS_ASSUME_NONNULL_END
