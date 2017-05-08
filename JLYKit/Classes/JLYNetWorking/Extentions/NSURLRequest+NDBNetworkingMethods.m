//
//  NSURLRequest+JLYNetworkingMethods.m
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "NSURLRequest+JLYNetworkingMethods.h"
#import <objc/runtime.h>

static void *JLYNetworkingRequestParams;

@implementation NSURLRequest (JLYNetworkingMethods)

- (void)setRequestParams:(id)requestParams{
    objc_setAssociatedObject(self, &JLYNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (id)requestParams{
    return objc_getAssociatedObject(self, &JLYNetworkingRequestParams);
}

@end
