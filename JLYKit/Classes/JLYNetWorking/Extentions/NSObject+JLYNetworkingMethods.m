//
//  NSObject+JLYNetworkingMethods.m
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "NSObject+JLYNetworkingMethods.h"

@implementation NSObject (JLYNetworkingMethods)

- (id)jly_defaultValue:(id)defaultData{
    if (![defaultData isKindOfClass:[self class]]) {
        return defaultData;
    }
    
    if ([self jly_isEmptyObject]) {
        return defaultData;
    }
    
    return self;
}

- (BOOL)jly_isEmptyObject{
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self length] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)self count] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        if ([(NSDictionary *)self count] == 0) {
            return YES;
        }
    }
    
    return NO;
}

@end
