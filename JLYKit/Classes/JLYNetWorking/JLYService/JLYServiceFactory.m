//
//  NDBServiceFactory.m
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYServiceFactory.h"

/*************************************************************************/

NSString * const kJLYServiceManager = @"kJLYServiceManager";


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
    if ([identifier isEqualToString:kJLYServiceManager]) {
        return [[NSClassFromString(@"GFServiceManager") alloc] init];
    }
    
    return nil;
}

@end
