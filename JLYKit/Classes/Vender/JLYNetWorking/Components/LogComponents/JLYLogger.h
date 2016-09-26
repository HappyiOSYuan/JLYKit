//
//  NDBLogger.h
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JLYService.h"
#import "JLYLoggerConfiguration.h"
#import "JLYURLResponse.h"

NS_ASSUME_NONNULL_BEGIN
@interface JLYLogger : NSObject

@property (nonatomic, strong, readonly) JLYLoggerConfiguration *configParams;

+ (void)logDebugInfoWithRequest:(NSURLRequest *)request
                        apiName:(NSString *)apiName
                        service:(JLYService *)service
                  requestParams:(id _Nullable)requestParams
                     httpMethod:(NSString *)httpMethod;
+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse * _Nullable)response
                   resposeString:(NSString * _Nullable)responseString
                         request:(NSURLRequest *)request
                           error:(NSError *)error;
+ (void)logDebugInfoWithCachedResponse:(JLYURLResponse *)response
                            methodName:(NSString *)methodName
                     serviceIdentifier:(JLYService *)service;

+ (instancetype)sharedInstance;
- (void)logWithActionCode:(NSString *)actionCode params:(NSDictionary<NSString * ,id> *)params;

@end
NS_ASSUME_NONNULL_END
