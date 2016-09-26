//
//  NDBURLResponse.h
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JLYNetworkingConfiguration.h"

NS_ASSUME_NONNULL_BEGIN
@interface JLYURLResponse : NSObject

@property (nonatomic, assign, readonly) JLYURLResponseStatus status;
@property (nonatomic, copy, readonly) NSString *contentString;
@property (nonatomic, copy, readonly) id content;
@property (nonatomic, assign, readonly) NSInteger requestId;
@property (nonatomic, copy, readonly) NSURLRequest *request;
@property (nonatomic, copy, readonly) NSData *responseData;
@property (nonatomic, copy, nullable) NSDictionary<NSString * ,id> *requestParams;
@property (nonatomic, assign, readonly) BOOL isCache;

- (instancetype)initWithResponseString:(NSString * _Nullable)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData * _Nullable)responseData
                                status:(JLYURLResponseStatus)status;

- (instancetype)initWithResponseString:(NSString * _Nullable)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData * _Nullable)responseData
                                 error:(NSError * _Nullable)error;

// 使用initWithData的response，它的isCache是YES，上面两个函数生成的response的isCache是NO
- (instancetype)initWithData:(NSData *)data;

@end
NS_ASSUME_NONNULL_END
