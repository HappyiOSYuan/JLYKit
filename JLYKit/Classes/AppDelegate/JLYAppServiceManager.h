//
//  JLYAppService.h
//  GenericFramework
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define JLY_EXPORT_SERVICE(name) \
+ (void)load \
{ \
[[JLYAppServiceManager sharedManager] registerService:[self new]]; \
} \
- (NSString *)serviceName \
{ \
return @#name; \
}

NS_ASSUME_NONNULL_BEGIN

@protocol JLYAppService <UIApplicationDelegate>

@required
- (NSString *)serviceName;

@end

@interface JLYAppServiceManager : NSObject

+ (instancetype)sharedManager;
- (void)registerService:(id<JLYAppService>)service;
- (BOOL)proxyCanResponseToSelector:(SEL)aSelector;
- (void)proxyForwardInvocation:(NSInvocation *)anInvocation;

@end

NS_ASSUME_NONNULL_END
