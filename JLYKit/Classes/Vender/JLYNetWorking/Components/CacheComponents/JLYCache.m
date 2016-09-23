//
//  NDBCache.m
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYCache.h"
#import <JLYKit/NSDictionary+JLYNetworkingMethods.h>
#import "JLYNetworkingConfiguration.h"

@interface JLYCache ()

@property (nonatomic, strong) NSCache *cache;

@end

@implementation JLYCache
#pragma mark - getters and setters
- (NSCache *)cache{
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = kJLYCacheCountLimit;
    }
    return _cache;
}

#pragma mark - life cycle

static JLYCache * instance = nil;

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

#pragma mark - public method
- (NSData *)fetchCachedDataWithServiceIdentifier:(NSString *)serviceIdentifier
                                      methodName:(NSString *)methodName
                                   requestParams:(NSDictionary<NSString * ,id> *)requestParams{
    return [self fetchCachedDataWithKey:[self keyWithServiceIdentifier:serviceIdentifier
                                                            methodName:methodName
                                                         requestParams:requestParams]];
}

- (void)saveCacheWithData:(NSData *)cachedData
        serviceIdentifier:(NSString *)serviceIdentifier
               methodName:(NSString *)methodName
            requestParams:(NSDictionary<NSString * ,id> *)requestParams{
    [self saveCacheWithData:cachedData
                        key:[self keyWithServiceIdentifier:serviceIdentifier
                                                methodName:methodName
                                             requestParams:requestParams]];
}

- (void)deleteCacheWithServiceIdentifier:(NSString *)serviceIdentifier
                              methodName:(NSString *)methodName
                           requestParams:(NSDictionary<NSString * ,id> *)requestParams{
    [self deleteCacheWithKey:[self keyWithServiceIdentifier:serviceIdentifier
                                                 methodName:methodName
                                              requestParams:requestParams]];
}

- (NSData *)fetchCachedDataWithKey:(NSString *)key{
    JLYCachedObject *cachedObject = [self.cache objectForKey:key];
    if (cachedObject.isOutdated || cachedObject.isEmpty) {
        return nil;
    } else {
        return cachedObject.content;
    }
}

- (void)saveCacheWithData:(NSData *)cachedData key:(NSString *)key{
    JLYCachedObject *cachedObject = [self.cache objectForKey:key];
    if (cachedObject == nil) {
        cachedObject = [[JLYCachedObject alloc] init];
    }
    [cachedObject updateContent:cachedData];
    [self.cache setObject:cachedObject forKey:key];
}

- (void)deleteCacheWithKey:(NSString *)key{
    [self.cache removeObjectForKey:key];
}

- (void)clean{
    [self.cache removeAllObjects];
}

- (NSString *)keyWithServiceIdentifier:(NSString *)serviceIdentifier
                            methodName:(NSString *)methodName
                         requestParams:(NSDictionary<NSString * ,id> *)requestParams{
    return [NSString stringWithFormat:@"%@%@%@", serviceIdentifier, methodName, [requestParams jly_urlParamsStringSignature:NO]];
}

@end
