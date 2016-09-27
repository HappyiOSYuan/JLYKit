//
//  NDBServiceFactory.h
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JLYService.h"

NS_ASSUME_NONNULL_BEGIN
@interface JLYServiceFactory : NSObject

+ (instancetype)sharedInstance;
- (__kindof JLYService<JLYServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier;

@end
NS_ASSUME_NONNULL_END