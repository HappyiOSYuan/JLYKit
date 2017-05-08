//
//  NDBRequestGenerator.m
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYRequestGenerator.h"
#import "JLYSignatureGenerator.h"
#import "JLYServiceFactory.h"
#import "JLYCommonParamsGenerator.h"
#import "NSDictionary+JLYNetworkingMethods.h"
#import "JLYNetworkingConfiguration.h"
#import "NSObject+JLYNetworkingMethods.h"
#import "AFNetworking.h"
#import "JLYService.h"
#import "NSObject+JLYNetworkingMethods.h"
#import "JLYLogger.h"
#import "NSURLRequest+JLYNetworkingMethods.h"

@interface JLYRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation JLYRequestGenerator

#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kJLYNetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}

#pragma mark - public methods
static JLYRequestGenerator * instance = nil;

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(id)requestParams
                                               methodName:(NSString *)methodName{
    JLYService *service = [[JLYServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    
    NSMutableDictionary<NSString * ,id>*sigParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    sigParams[@"api_key"] = service.publicKey;
    NSString *signature = [JLYSignatureGenerator signGetWithSigParams:sigParams
                                                           methodName:methodName
                                                           apiVersion:service.apiVersion
                                                           privateKey:service.privateKey
                                                            publicKey:service.publicKey];
    
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[JLYCommonParamsGenerator commonParamsDictionary]];
    //[allParams addEntriesFromDictionary:sigParams];
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?%@&sig=%@", service.apiBaseUrl, service.apiVersion, methodName, [allParams jly_urlParamsStringSignature:NO], signature];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:nil error:NULL];
    request.timeoutInterval = kJLYNetworkingTimeoutSeconds;
    request.requestParams = requestParams;
    [JLYLogger logDebugInfoWithRequest:request
                               apiName:methodName
                               service:service
                         requestParams:requestParams
                            httpMethod:@"GET"];
    return request;
}

- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                             requestParams:(id)requestParams
                                                methodName:(NSString *)methodName{
    JLYService *service = [[JLYServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    //NSString *signature = [NDBSignatureGenerator signPostWithApiParams:requestParams privateKey:service.privateKey publicKey:service.publicKey];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST"
                                                                       URLString:urlString
                                                                      parameters:requestParams
                                                                           error:NULL];
    request.requestParams = requestParams;
    request.timeoutInterval = kJLYNetworkingTimeoutSeconds;
    [JLYLogger logDebugInfoWithRequest:request
                               apiName:methodName
                               service:service
                         requestParams:requestParams
                            httpMethod:@"POST"];
    return request;
}

- (NSURLRequest *)generateImageRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                              requestParams:(id)requestParams
                                                 methodName:(NSString *)methodName{
    JLYService *service = [[JLYServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST"
                                                                       URLString:urlString
                                                                      parameters:requestParams
                                                                           error:NULL];
    request.requestParams = requestParams;
    request.timeoutInterval = kJLYNetworkingTimeoutSeconds;
    [JLYLogger logDebugInfoWithRequest:request
                               apiName:methodName
                               service:service
                         requestParams:requestParams
                            httpMethod:@"POST"];
    return request;
}

- (NSURLRequest *)generateRestfulGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                                   requestParams:(id)requestParams
                                                      methodName:(NSString *)methodName{
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[JLYCommonParamsGenerator commonParamsDictionary]];
    //[allParams addEntriesFromDictionary:requestParams];
    
    JLYService *service = [[JLYServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *signature = [JLYSignatureGenerator signRestfulGetWithAllParams:allParams
                                                                  methodName:methodName
                                                                  apiVersion:service.apiVersion
                                                                  privateKey:service.privateKey];
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?%@", service.apiBaseUrl, service.apiVersion, methodName, [allParams jly_urlParamsStringSignature:NO]];
    
    NSDictionary *restfulHeader = [self commRESTHeadersWithService:service signature:signature];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:kJLYNetworkingTimeoutSeconds];
    request.HTTPMethod = @"GET";
    [restfulHeader enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    request.requestParams = requestParams;
    request.timeoutInterval = kJLYNetworkingTimeoutSeconds;
    [JLYLogger logDebugInfoWithRequest:request
                               apiName:methodName
                               service:service
                         requestParams:requestParams
                            httpMethod:@"RESTful GET"];
    return request;
}

- (NSURLRequest *)generateRestfulPOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                                    requestParams:(id)requestParams
                                                       methodName:(NSString *)methodName{
    JLYService *service = [[JLYServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSDictionary *commonParams = [JLYCommonParamsGenerator commonParamsDictionary];
    NSString *signature = [JLYSignatureGenerator signRestfulPOSTWithApiParams:requestParams
                                                                 commonParams:commonParams
                                                                   methodName:methodName
                                                                   apiVersion:service.apiVersion
                                                                   privateKey:service.privateKey];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];
    
    NSDictionary *restfulHeader = [self commRESTHeadersWithService:service signature:signature];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:kJLYNetworkingTimeoutSeconds];
    request.HTTPMethod = @"POST";
    [restfulHeader enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:NULL];
    request.requestParams = requestParams;
    request.timeoutInterval = kJLYNetworkingTimeoutSeconds;
    [JLYLogger logDebugInfoWithRequest:request
                               apiName:methodName
                               service:service
                         requestParams:requestParams
                            httpMethod:@"RESTful POST"];
    return request;
}

- (NSURLRequest *)generateGoolgeMapAPIRequestWithParams:(id)requestParams
                                      serviceIdentifier:(NSString *)serviceIdentifier{
    JLYService *service = [[JLYServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *paramsString = [requestParams jly_urlParamsStringSignature:NO];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@", service.apiBaseUrl, service.apiVersion, paramsString]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:kJLYNetworkingTimeoutSeconds];
    [request setValue:@"zh-CN,zh;q=0.8,en;q=0.6" forHTTPHeaderField:@"Accept-Language"];
    request.requestParams = requestParams;
    request.timeoutInterval = kJLYNetworkingTimeoutSeconds;
    [JLYLogger logDebugInfoWithRequest:request
                               apiName:@"Google Map API"
                               service:service
                         requestParams:requestParams
                            httpMethod:@"GET"];
    return request;
}

#pragma mark - private methods
- (NSDictionary *)commRESTHeadersWithService:(JLYService *)service signature:(NSString *)signature{
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
    [headerDic setValue:signature forKey:@"sig"];
    [headerDic setValue:service.publicKey forKey:@"key"];
    [headerDic setValue:@"application/json" forKey:@"Accept"];
    [headerDic setValue:@"application/json" forKey:@"Content-Type"];
    NSDictionary *loginResult = [[NSUserDefaults standardUserDefaults] objectForKey:@"______"];
    if (loginResult[@"auth_token"]) {
        [headerDic setValue:loginResult[@"auth_token"] forKey:@"AuthToken"];
    }
    return headerDic;
}

@end
