//
//  NDBCommonParamsGenerator.m
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYCommonParamsGenerator.h"
#import "JLYAppContext.h"
#import "NSDictionary+JLYNetworkingMethods.h"

@implementation JLYCommonParamsGenerator

+ (NSDictionary<NSString * ,id>*)commonParamsDictionary{
    JLYAppContext *context = [JLYAppContext sharedInstance];
    return @{
             @"cid":context.cid,
             @"ostype2":context.ostype2,
             @"udid2":context.udid2,
             @"uuid2":context.uuid2,
             @"app":context.appName,
             @"cv":context.cv,
             @"from":context.from,
             @"m":context.m,
             @"macid":context.macid,
             @"o":context.o,
             @"pm":context.pm,
             @"qtime":context.qtime,
             @"uuid":context.uuid,
             @"i":context.i,
             @"v":context.v
             };
}

+ (NSDictionary<NSString * ,id>*)commonParamsDictionaryForLog{
    JLYAppContext *context = [JLYAppContext sharedInstance];
    return @{
             @"guid":context.guid,
             @"dvid":context.dvid,
             @"net":context.net,
             @"ver":context.ver,
             @"ip":context.ip,
             @"mac":context.mac,
             @"geo":context.geo,
             @"uid":context.uid,
             @"chat_id":context.chatid,
             @"ccid":context.ccid,
             @"gcid":context.gcid,
             @"p":context.p,
             @"os":context.os,
             @"v":context.v,
             @"app":context.app,
             @"ch":context.channelID,
             @"ct":context.ct,
             @"pmodel":context.pmodel
             };
}


@end
