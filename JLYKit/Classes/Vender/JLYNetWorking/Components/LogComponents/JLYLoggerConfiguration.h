//
//  NDBLoggerConfiguration.h
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JLYAppContext.h"

NS_ASSUME_NONNULL_BEGIN
@interface JLYLoggerConfiguration : NSObject

/** 渠道ID */
@property (nonatomic, strong) NSString *channelID;

/** app标志 */
@property (nonatomic, strong) NSString *appKey;

/** app名字 */
@property (nonatomic, strong) NSString *logAppName;

/** 服务名 */
@property (nonatomic, assign) NSString *serviceType;

/** 记录log用到的webapi方法名 */
@property (nonatomic, strong) NSString *sendLogMethod;

/** 记录action用到的webapi方法名 */
@property (nonatomic, strong) NSString *sendActionMethod;

/** 发送log时使用的key */
@property (nonatomic, strong) NSString *sendLogKey;

/** 发送Action记录时使用的key */
@property (nonatomic, strong) NSString *sendActionKey;

- (void)configWithAppType:(JLYAppType)appType;

@end
NS_ASSUME_NONNULL_END