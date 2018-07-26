//
//  NDBServiceFactory.m
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYServiceFactory.h"

/*************************************************************************/

NSString * const kGFServiceManager = @"kGFServiceManager";
NSString * const kGFLogonServiceManager = @"kGFLogonServiceManager";
NSString * const kGFCommodityServiceManager = @"kGFCommodityServiceManager";
NSString * const kGFProjectServiceManager = @"kGFProjectServiceManager";
NSString * const kGFProjectManageServiceManager = @"kGFProjectManangeServiceManager";
NSString * const kGFSalesManageServiceManager = @"kGFSalesManageServiceManager";
NSString * const kGFRequestServiceManager = @"GFRequestServiceManager";
NSString * const kGFContactServiceManager = @"GFContactServiceManager";
NSString * const kGFCarManageServiceManager = @"GFCarManageServiceManager";
NSString * const kGFReimburseServiceManager = @"GFReimburseServiceManager";
NSString * const kGFHomeServiceManager = @"GFHomeServiceManager";


@interface JLYServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;

@end

@implementation JLYServiceFactory

#pragma mark - getters and setters
- (NSMutableDictionary<NSString * ,id> *)serviceStorage{
    if (_serviceStorage == nil) {
        _serviceStorage = [NSMutableDictionary dictionary];
    }
    return _serviceStorage;
}

#pragma mark - life cycle
static JLYServiceFactory * instance = nil;

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
- (__kindof JLYService<JLYServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier{
    if (self.serviceStorage[identifier] == nil) {
        self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
    }
    return self.serviceStorage[identifier];
}

#pragma mark - private methods
- (__kindof JLYService<JLYServiceProtocal> *)newServiceWithIdentifier:(NSString *)identifier{
    if ([identifier isEqualToString:kGFServiceManager]) {
        return [[NSClassFromString(@"GFServiceManager") alloc] init];
    }
    if ([identifier isEqualToString:kGFLogonServiceManager]){
        return [[NSClassFromString(@"GFLogonServiceManager")alloc] init];
    }
    if ([identifier isEqualToString:kGFCommodityServiceManager]){
        return [[NSClassFromString(@"GFCommodityServiceManager")alloc] init];
    }
    if ([identifier isEqualToString:kGFProjectServiceManager]){
        return [[NSClassFromString(@"GFProjectServiceManager")alloc] init];
    }
    if ([identifier isEqualToString:kGFProjectManageServiceManager]){
        return [[NSClassFromString(@"GFProjectManageServiceManager")alloc] init];
    }
    if ([identifier isEqualToString:kGFSalesManageServiceManager]){
        return [[NSClassFromString(@"GFSalesManageServiceManager")alloc] init];
    }
    if ([identifier isEqualToString:kGFRequestServiceManager]){
        return [[NSClassFromString(@"GFRequestServiceManager")alloc] init];
    }
    if ([identifier isEqualToString:kGFContactServiceManager]){
        return [[NSClassFromString(@"GFContactServiceManager")alloc] init];
    }
    if ([identifier isEqualToString:kGFCarManageServiceManager]){
        return [[NSClassFromString(@"GFCarManageServiceManager")alloc] init];
    }
    if ([identifier isEqualToString:kGFReimburseServiceManager]){
        return [[NSClassFromString(@"GFReimburseServiceManager")alloc] init];
    }
    if ([identifier isEqualToString:kGFHomeServiceManager]){
        return [[NSClassFromString(@"GFHomeServiceManager")alloc] init];
    }
    return nil;
}

@end
