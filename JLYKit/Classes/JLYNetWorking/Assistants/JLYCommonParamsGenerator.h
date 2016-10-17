//
//  NDBCommonParamsGenerator.h
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface JLYCommonParamsGenerator : NSObject

+ (NSDictionary<NSString * ,id>*)commonParamsDictionary;
+ (NSDictionary<NSString * ,id>*)commonParamsDictionaryForLog;

@end
NS_ASSUME_NONNULL_END
