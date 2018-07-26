//
//  JLYNetworkingConfiguration.h
//  JLYAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#ifndef JLYAPIManager_JLYNetworkingConfiguration_h
#define JLYAPIManager_JLYNetworkingConfiguration_h

typedef NS_ENUM(NSInteger, JLYAppType) {
    JLYAppTypeManager
};

typedef NS_ENUM(NSUInteger, JLYURLResponseStatus){
    JLYURLResponseStatusSuccess, //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的RTApiBaseManager来决定。
    JLYURLResponseStatusErrorTimeout,
    JLYURLResponseStatusErrorNoNetwork // 默认除了超时以外的错误都是无网络错误。
};

static NSTimeInterval kJLYNetworkingTimeoutSeconds = 5.0f;
static NSString *JLYKeychainServiceName = @"com.TJBT.BaseViewController";
static NSString *JLYUDIDName = @"BaseViewControllerAppsUDID";
static NSString *JLYPasteboardType = @"BaseViewControllerAppsContent";

static BOOL kJLYShouldCache = NO;
static NSTimeInterval kJLYCacheOutdateTimeSeconds = 0; // cache过期时间
static NSUInteger kJLYCacheCountLimit = 1000; // 最多1000条cache

extern NSString * const kGFServiceManager;
extern NSString * const kGFLogonServiceManager;
extern NSString * const kGFCommodityServiceManager;
extern NSString * const kGFProjectServiceManager;
extern NSString * const kGFProjectManageServiceManager;
extern NSString * const kGFSalesManageServiceManager;
extern NSString * const kGFRequestServiceManager;
extern NSString * const kGFContactServiceManager;
extern NSString * const kGFCarManageServiceManager;
extern NSString * const kGFReimburseServiceManager;
extern NSString * const kGFHomeServiceManager;

#endif
