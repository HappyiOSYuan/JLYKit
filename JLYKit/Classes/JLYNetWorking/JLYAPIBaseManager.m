//
//  RTAPIBaseManager.m
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYAPIBaseManager.h"
#import "JLYNetworking.h"
#import "JLYCache.h"
#import "JLYLogger.h"
#import "JLYServiceFactory.h"

#define AXCallAPI(REQUEST_METHOD, REQUEST_ID)                                                       \
{                                                                                       \
REQUEST_ID = [[JLYApiProxy sharedInstance] call##REQUEST_METHOD##WithParams:apiParams serviceIdentifier:self.child.serviceType methodName:self.child.methodName success:^(JLYURLResponse *response) { \
[self successedOnCallingAPI:response];                                          \
} fail:^(JLYURLResponse *response) {                                                \
[self failedOnCallingAPI:response withErrorType:JLYAPIManagerErrorTypeDefault];  \
}];                                                                                 \
[self.requestIdList addObject:@(REQUEST_ID)];                                          \
}

@interface JLYAPIBaseManager ()

@property (nonatomic, strong, readwrite) id fetchedRawData;

@property (nonatomic, copy, readwrite) NSString *errorMessage;
@property (nonatomic, readwrite) JLYAPIManagerErrorType errorType;
@property (nonatomic, strong) NSMutableArray<NSNumber *>*requestIdList;
@property (nonatomic, strong) JLYCache *cache;

@end

@implementation JLYAPIBaseManager

#pragma mark - getters and setters
- (JLYCache *)cache{
    if (!_cache) {
        _cache = [JLYCache sharedInstance];
    }
    return _cache;
}

- (NSMutableArray<NSNumber *>*)requestIdList{
    if (!_requestIdList) {
        _requestIdList = [[NSMutableArray alloc] init];
    }
    return _requestIdList;
}

- (BOOL)isReachable{
    BOOL isReachability = [JLYAppContext sharedInstance].isReachable;
    if (!isReachability) {
        self.errorType = JLYAPIManagerErrorTypeNoNetWork;
    }
    return isReachability;
}

- (BOOL)isLoading{
    return [self.requestIdList count] > 0;
}

#pragma mark - life cycle
- (instancetype)init{
    self = [super init];
    if (self) {
        _delegate = nil;
        _validator = nil;
        _paramSource = nil;
        
        _fetchedRawData = nil;
        
        _errorMessage = nil;
        _errorType = JLYAPIManagerErrorTypeDefault;
        
        if ([self conformsToProtocol:@protocol(JLYAPIManager)]) {
            self.child = (id <JLYAPIManager>)self;
        }else {
            // 不遵守这个protocol的就让他crash，防止派生类乱来。
            NSAssert(NO, @"子类必须要实现APIManager这个protocol。");
        }
    }
    return self;
}

- (void)dealloc{
    [self cancelAllRequests];
    self.requestIdList = nil;
}

#pragma mark - public methods
- (void)cancelAllRequests{
    [[JLYApiProxy sharedInstance] cancelRequestWithRequestIDList:self.requestIdList];
    [self.requestIdList removeAllObjects];
}

- (void)cancelRequestWithRequestId:(NSInteger)requestID{
    [self removeRequestIdWithRequestID:requestID];
    [[JLYApiProxy sharedInstance] cancelRequestWithRequestID:@(requestID)];
}

- (id)fetchDataWithReformer:(id<JLYAPIManagerCallbackDataReformer>)reformer{
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(manager:reformData:)]) {
        resultData = [reformer manager:self reformData:self.fetchedRawData];
    } else {
        resultData = [self.fetchedRawData mutableCopy];
    }
    return resultData;
}

#pragma mark - calling api
- (NSInteger)loadData{
    id params = [self.paramSource paramsForApi:self];
    NSInteger requestId = [self loadDataWithParams:params];
    return requestId;
}

- (NSInteger)loadDataWithParams:(id)params{
    NSInteger requestId = 0;
    id apiParams = [self reformParams:params];
    if ([self shouldCallAPIWithParams:apiParams]) {
        if ([self.validator manager:self isCorrectWithParamsData:apiParams]) {
            
            // 先检查一下是否有缓存
            if ([self shouldCache] && [self hasCacheWithParams:apiParams]) {
                return 0;
            }
            
            // 实际的网络请求
            if ([self isReachable]) {
                switch (self.child.requestType)
                {
                    case JLYAPIManagerRequestTypeGet:
                        AXCallAPI(GET, requestId);
                        break;
                    case JLYAPIManagerRequestTypePost:
                        AXCallAPI(POST, requestId);
                        break;
                    case JLYAPIManagerRequestTypeImage:
                        AXCallAPI(Image, requestId);
                        break;
                    case JLYAPIManagerRequestTypeRestGet:
                        AXCallAPI(RestfulGET, requestId);
                        break;
                    case JLYAPIManagerRequestTypeRestPost:
                        AXCallAPI(RestfulPOST, requestId);
                        break;
                    default:
                        break;
                }
                
                NSMutableDictionary<NSString * ,id>*params = [apiParams mutableCopy];
                params[kRTAPIBaseManagerRequestID] = @(requestId);
                [self afterCallingAPIWithParams:params];
                return requestId;
                
            } else {
                [self failedOnCallingAPI:nil withErrorType:JLYAPIManagerErrorTypeNoNetWork];
                return requestId;
            }
        } else {
            [self failedOnCallingAPI:nil withErrorType:JLYAPIManagerErrorTypeParamsError];
            return requestId;
        }
    }
    return requestId;
}

#pragma mark - api callbacks
- (void)apiCallBack:(JLYURLResponse *)response{
    if (response.status == JLYURLResponseStatusSuccess) {
        [self successedOnCallingAPI:response];
    }else{
        [self failedOnCallingAPI:response withErrorType:JLYAPIManagerErrorTypeTimeout];
    }
}

- (void)successedOnCallingAPI:(JLYURLResponse *)response{
    if (response.content) {
        self.fetchedRawData = [response.content copy];
    } else {
        self.fetchedRawData = [response.responseData copy];
    }
    [self removeRequestIdWithRequestID:response.requestId];
    if ([self.validator manager:self isCorrectWithCallBackData:response.content]) {
        
        if (kJLYShouldCache && !response.isCache) {
            [self.cache saveCacheWithData:response.responseData serviceIdentifier:self.child.serviceType methodName:self.child.methodName requestParams:response.requestParams];
        }
        
        [self beforePerformSuccessWithResponse:response];
        [self.delegate managerCallAPIDidSuccess:self];
        [self afterPerformSuccessWithResponse:response];
    } else {
        [self failedOnCallingAPI:response withErrorType:JLYAPIManagerErrorTypeNoContent];
    }
}

- (void)failedOnCallingAPI:(JLYURLResponse *)response withErrorType:(JLYAPIManagerErrorType)errorType{
    self.errorType = errorType;
    [self removeRequestIdWithRequestID:response.requestId];
    [self beforePerformFailWithResponse:response];
    [self.delegate managerCallAPIDidFailed:self];
    [self afterPerformFailWithResponse:response];
}

#pragma mark - method for interceptor

/*
 拦截器的功能可以由子类通过继承实现，也可以由其它对象实现,两种做法可以共存
 当两种情况共存的时候，子类重载的方法一定要调用一下super
 然后它们的调用顺序是BaseManager会先调用子类重载的实现，再调用外部interceptor的实现
 
 notes:
 正常情况下，拦截器是通过代理的方式实现的，因此可以不需要以下这些代码
 但是为了将来拓展方便，如果在调用拦截器之前manager又希望自己能够先做一些事情，所以这些方法还是需要能够被继承重载的
 所有重载的方法，都要调用一下super,这样才能保证外部interceptor能够被调到
 这就是decorate pattern
 */
- (void)beforePerformSuccessWithResponse:(JLYURLResponse *)response{
    self.errorType = JLYAPIManagerErrorTypeSuccess;
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beforePerformSuccessWithResponse:)]) {
        [self.interceptor manager:self beforePerformSuccessWithResponse:response];
    }
}

- (void)afterPerformSuccessWithResponse:(JLYURLResponse *)response{
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterPerformSuccessWithResponse:)]) {
        [self.interceptor manager:self afterPerformSuccessWithResponse:response];
    }
}

- (void)beforePerformFailWithResponse:(JLYURLResponse *)response{
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beforePerformFailWithResponse:)]) {
        [self.interceptor manager:self beforePerformFailWithResponse:response];
    }
}

- (void)afterPerformFailWithResponse:(JLYURLResponse *)response{
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterPerformFailWithResponse:)]) {
        [self.interceptor manager:self afterPerformFailWithResponse:response];
    }
}

//只有返回YES才会继续调用API
- (BOOL)shouldCallAPIWithParams:(id)params{
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:shouldCallAPIWithParams:)]) {
        return [self.interceptor manager:self shouldCallAPIWithParams:params];
    } else {
        return YES;
    }
}

- (void)afterCallingAPIWithParams:(id)params{
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterCallingAPIWithParams:)]) {
        [self.interceptor manager:self afterCallingAPIWithParams:params];
    }
}

#pragma mark - method for child
- (void)cleanData{
    IMP childIMP = [self.child methodForSelector:@selector(cleanData)];
    IMP selfIMP = [self methodForSelector:@selector(cleanData)];
    
    if (childIMP == selfIMP) {
        self.fetchedRawData = nil;
        self.errorMessage = nil;
        self.errorType = JLYAPIManagerErrorTypeDefault;
    } else {
        if ([self.child respondsToSelector:@selector(cleanData)]) {
            [self.child cleanData];
        }
    }
}

//如果需要在调用API之前额外添加一些参数，比如pageNumber和pageSize之类的就在这里添加
//子类中覆盖这个函数的时候就不需要调用[super reformParams:params]了
- (id)reformParams:(id)params{
    IMP childIMP = [self.child methodForSelector:@selector(reformParams:)];
    IMP selfIMP = [self methodForSelector:@selector(reformParams:)];
    
    if (childIMP == selfIMP) {
        return params;
    } else {
        // 如果child是继承得来的，那么这里就不会跑到，会直接跑子类中的IMP。
        // 如果child是另一个对象，就会跑到这里
        id result = nil;
        result = [self.child reformParams:params];
        if (result) {
            return result;
        } else {
            return params;
        }
    }
}

- (BOOL)shouldCache{
    return kJLYShouldCache;
}

#pragma mark - private methods
- (void)removeRequestIdWithRequestID:(NSInteger)requestId{
    __block NSNumber *requestIDToRemove = nil;
    [self.requestIdList enumerateObjectsUsingBlock:^(NSNumber *storedRequestId ,NSUInteger idx ,BOOL *stop){
        if ([storedRequestId integerValue] == requestId) {
            requestIDToRemove = storedRequestId;
        }
    }];
    if (requestIDToRemove) {
        [self.requestIdList removeObject:requestIDToRemove];
    }
}

- (BOOL)hasCacheWithParams:(id)params{
    NSString *serviceIdentifier = self.child.serviceType;
    NSString *methodName = self.child.methodName;
    NSData *result = [self.cache fetchCachedDataWithServiceIdentifier:serviceIdentifier
                                                           methodName:methodName
                                                        requestParams:params];
    
    if (!result) {
        return NO;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        JLYURLResponse *response = [[JLYURLResponse alloc] initWithData:result];
        response.requestParams = params;
        [JLYLogger logDebugInfoWithCachedResponse:response
                                       methodName:methodName
                                serviceIdentifier:[[JLYServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier]];
        [self successedOnCallingAPI:response];
    });
    return YES;
}

@end
