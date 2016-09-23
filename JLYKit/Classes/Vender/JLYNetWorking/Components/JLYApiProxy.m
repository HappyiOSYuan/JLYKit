//
//  NDBApiProxy.m
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYApiProxy.h"
#import "AFHTTPSessionOperation.h"
#import "JLYRequestGenerator.h"
#import "JLYLogger.h"
#import "NSURLRequest+JLYNetworkingMethods.h"
#import "AFNetworking.h"

static NSString * const kNDBApiProxyDispatchItemKeyCallbackSuccess = @"kNDBApiProxyDispatchItemCallbackSuccess";
static NSString * const kNDBApiProxyDispatchItemKeyCallbackFail = @"kNDBApiProxyDispatchItemCallbackFail";

@interface JLYApiProxy ()

@property (nonatomic, strong) NSMutableDictionary<NSNumber * ,NSOperation *> *dispatchTable;
@property (nonatomic, strong) NSNumber *recordedRequestId;

//AFNetworking stuff
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end
@implementation JLYApiProxy
#pragma mark -
#pragma mark - SettersAndGetters
- (NSMutableDictionary<NSNumber * ,NSOperation *> *)dispatchTable{
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (AFHTTPSessionManager *)sessionManager{
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    }
    return _sessionManager;
}
#pragma mark -
#pragma mark - LifeCycle
static JLYApiProxy * instance = nil;

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

#pragma mark - public methods
- (NSInteger)callGETWithParams:(NSDictionary<NSString * ,id> *)params
             serviceIdentifier:(NSString *)servieIdentifier
                    methodName:(NSString *)methodName
                       success:(NDBCallback)success
                          fail:(NDBCallback)fail{
    NSURLRequest *request = [[JLYRequestGenerator sharedInstance] generateGETRequestWithServiceIdentifier:servieIdentifier
                                                                                            requestParams:params
                                                                                               methodName:methodName];
    NSNumber *requestId = [self callApiTaskWithMethodName:@"GET"
                                               andRequest:request
                                                  success:success fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callPOSTWithParams:(NSDictionary<NSString * ,id> *)params
              serviceIdentifier:(NSString *)servieIdentifier
                     methodName:(NSString *)methodName
                        success:(NDBCallback)success
                           fail:(NDBCallback)fail{
    NSURLRequest *request = [[JLYRequestGenerator sharedInstance] generatePOSTRequestWithServiceIdentifier:servieIdentifier
                                                                                             requestParams:params
                                                                                                methodName:methodName];
    NSNumber *requestId = [self callApiTaskWithMethodName:@"POST"
                                               andRequest:request
                                                  success:success
                                                     fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callImageWithParams:(NSDictionary<NSString * ,id> *)params
               serviceIdentifier:(NSString *)servieIdentifier
                      methodName:(NSString *)methodName
                         success:(NDBCallback)success
                            fail:(NDBCallback)fail{
    NSURLRequest *request = [[JLYRequestGenerator sharedInstance] generateImageRequestWithServiceIdentifier:servieIdentifier
                                                                                              requestParams:params
                                                                                                 methodName:methodName];
    NSNumber *requestId = [self callApiTaskWithMethodName:@"Image"
                                               andRequest:request
                                                  success:success
                                                     fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callRestfulGETWithParams:(NSDictionary<NSString * ,id> *)params
                    serviceIdentifier:(NSString *)servieIdentifier
                           methodName:(NSString *)methodName
                              success:(NDBCallback)success
                                 fail:(NDBCallback)fail{
    NSURLRequest *request = [[JLYRequestGenerator sharedInstance] generateRestfulGETRequestWithServiceIdentifier:servieIdentifier
                                                                                                   requestParams:params
                                                                                                      methodName:methodName];
    NSNumber *requestId = [self callApiTaskWithMethodName:@"GET"
                                               andRequest:request
                                                  success:success
                                                     fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callRestfulPOSTWithParams:(NSDictionary<NSString * ,id> *)params
                     serviceIdentifier:(NSString *)servieIdentifier
                            methodName:(NSString *)methodName
                               success:(NDBCallback)success
                                  fail:(NDBCallback)fail{
    NSURLRequest *request = [[JLYRequestGenerator sharedInstance] generateRestfulPOSTRequestWithServiceIdentifier:servieIdentifier
                                                                                                    requestParams:params
                                                                                                       methodName:methodName];
    NSNumber *requestId = [self callApiTaskWithMethodName:@"POST"
                                               andRequest:request
                                                  success:success
                                                     fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callGoogleMapAPIWithParams:(NSDictionary<NSString * ,id> *)params
                      serviceIdentifier:(NSString *)serviceIdentifier
                                success:(NDBCallback)success
                                   fail:(NDBCallback)fail{
    NSURLRequest *request = [[JLYRequestGenerator sharedInstance] generateGoolgeMapAPIRequestWithParams:params
                                                                                      serviceIdentifier:serviceIdentifier];
    NSNumber *requestId = [self callApiTaskWithMethodName:nil
                                               andRequest:request
                                                  success:success
                                                     fail:fail];
    return [requestId integerValue];
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID{
    NSOperation *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray<NSNumber *> *)requestIDList{
    [requestIDList enumerateObjectsUsingBlock:^(NSNumber *requestId ,NSUInteger idx ,BOOL *stop){
        [self cancelRequestWithRequestID:requestId];
    }];
}

#pragma mark - private methods
- (NSNumber *)callApiTaskWithMethodName:(NSString *)methodName
                             andRequest:(NSURLRequest *)request
                                success:(NDBCallback)success
                                   fail:(NDBCallback)fail{
    NSNumber *requestId = [self generateRequestId];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    AFHTTPSessionOperation *httpRequestOperation = [AFHTTPSessionOperation operationWithManager:self.sessionManager
                                                                                         HTTPMethod:methodName
                                                                                      URLString:[request.URL absoluteString]
                                                                                     parameters:request.requestParams
                                                                                 uploadProgress:^(NSProgress *uploadProgress){
                                                                                     
                                                                                 }
                                                                               downloadProgress:^(NSProgress *downloadProgress){
                                                                                   
                                                                               }
                                                                                        success:^(NSURLSessionDataTask *task, id responseObject){
                                                                                            AFHTTPSessionOperation *storedOperation = self.dispatchTable[requestId];
                                                                                            if (storedOperation == nil) {
                                                                                                // 如果这个operation是被cancel的，那就不用处理回调了。
                                                                                                return;
                                                                                            } else {
                                                                                                [self.dispatchTable removeObjectForKey:requestId];
                                                                                            }
                                                                                            [JLYLogger logDebugInfoWithResponse:nil
                                                                                                                  resposeString:responseObject
                                                                                                                        request:request
                                                                                                                          error:nil];
                                                                                            JLYURLResponse *response = [[JLYURLResponse alloc] initWithResponseString:responseObject
                                                                                                                                                            requestId:requestId
                                                                                                                                                              request:request
                                                                                                                                                         responseData:responseObject
                                                                                                                                                               status:JLYURLResponseStatusSuccess];
                                                                                            success?success(response):nil;
                                                                                        }
                                                                                        failure:^(NSURLSessionDataTask *task, NSError *error){
                                                                                            AFHTTPSessionOperation *storedOperation = self.dispatchTable[requestId];
                                                                                            if (storedOperation == nil) {
                                                                                                // 如果这个operation是被cancel的，那就不用处理回调了。
                                                                                                return;
                                                                                            } else {
                                                                                                [self.dispatchTable removeObjectForKey:requestId];
                                                                                            }
                                                                                            [JLYLogger logDebugInfoWithResponse:nil
                                                                                                                  resposeString:nil
                                                                                                                        request:request
                                                                                                                          error:error];
                                                                                            
                                                                                            JLYURLResponse *response = [[JLYURLResponse alloc] initWithResponseString:nil
                                                                                                                                                            requestId:requestId
                                                                                                                                                              request:request
                                                                                                                                                         responseData:nil
                                                                                                                                                                error:error];
                                                                                            fail?fail(response):nil;
                                                                                        }];
    self.dispatchTable[requestId] = httpRequestOperation;
    [queue addOperation:httpRequestOperation];
    return requestId;
}


- (NSNumber *)generateRequestId{
    if (_recordedRequestId == nil) {
        _recordedRequestId = @(1);
    } else {
        if ([_recordedRequestId integerValue] == NSIntegerMax) {
            _recordedRequestId = @(1);
        } else {
            _recordedRequestId = @([_recordedRequestId integerValue] + 1);
        }
    }
    return _recordedRequestId;
}
@end
