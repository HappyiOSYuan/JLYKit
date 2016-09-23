//
//  NSObject+JLYNetworkingMethods.h
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSObject (JLYNetworkingMethods)

- (id)jly_defaultValue:(id)defaultData;
- (BOOL)jly_isEmptyObject;

@end
NS_ASSUME_NONNULL_END