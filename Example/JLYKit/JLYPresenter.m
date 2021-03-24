//
//  JLYPresenter.m
//  JLYKit
//
//  Created by 袁宁 on 2016/11/24.
//  Copyright © 2016年 HappyiOSYuan. All rights reserved.
//

#import "JLYPresenter.h"
#import "JLYRouterProtocol.h"
#import <JLYKit/viewControllerConfig.h>

@implementation JLYPresenter

- (void)jly_handleDataWithIdentifer:(NSString *)identifer
                          andParams:(NSDictionary<NSString *,id> *)params
                  CompletionHandler:(JLYCompletionHandler)completionHandler{
    [JLYConvertInteractorToProtocol(id<JLYInteractorInput>) jly_doSomething];
}

- (void)jly_openVCWithIdentifer:(NSString *)identifer andParam:(NSDictionary<NSString *,id> *)params{
    [JLYConvertRoutingToProtocol(id<JLYRouterProtocol>) pushVC:params];
}

- (void)callBackBeforeSuccess:(id)obj{
    NSLog(@"callBackBeforeSuccess");
}

@end
