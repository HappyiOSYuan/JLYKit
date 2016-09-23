//
//  NSArray+JLYNetworkingMethods.h
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSArray (JLYNetworkingMethods)

- (NSString *)jly_paramsString;
- (NSString *)jly_jsonString;

@end
NS_ASSUME_NONNULL_END