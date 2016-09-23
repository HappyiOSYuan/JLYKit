//
//  UIDevice+identifierAddition.h
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIDevice (identifierAddition)

/*
 * @method uuid
 * @description apple identifier support iOS6 and iOS5 below
 */

- (NSString *)jly_uuid;
- (NSString *)jly_udid;
- (NSString *)jly_macaddress;
- (NSString *)jly_macaddressMD5;
- (NSString *)jly_machineType;
- (NSString *)jly_ostype;//显示“ios6，ios5”，只显示大版本号
- (NSString *)jly_createUUID;

//兼容旧版本
- (NSString *)uuid;
- (NSString *)udid;
- (NSString *)macaddress;
- (NSString *)macaddressMD5;
- (NSString *)machineType;
- (NSString *)ostype;//显示“ios6，ios5”，只显示大版本号
- (NSString *)createUUID;

@end
NS_ASSUME_NONNULL_END