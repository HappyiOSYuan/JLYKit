//
//  JLYBasePresenter.m
//  GenericFramework
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYBasePresenter.h"

@implementation JLYBasePresenter

- (void)jly_blindVC:(__kindof UIViewController<JLYBaseVCModuleProtocol> *)viewController{
    [self setValue:viewController forKey:@"userInterface"];
}

- (void)jly_handleDataWithIdentifer:(NSString *)identifer
                          andParams:(NSDictionary<NSString *,id> *)params
                  CompletionHandler:(JLYCompletionHandler)completionHandler{
    
}

@end
