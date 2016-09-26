//
//  JLYBaseInterector.m
//  GenericFramework
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYBaseInteractor.h"

@implementation JLYBaseInteractor

#pragma mark - PublicMethod
- (void)blindHandleWithCompletionHandler:(JLYCompletionHandler)completionHandler{
    [self blindHandleWithKey:JLYDATACOMPLETION CompletionHandler:completionHandler];
}

- (void)blindHandleWithKey:(NSString *)key CompletionHandler:(JLYCompletionHandler)completionHandler{
    self.blockDic[key] = [completionHandler copy];
}
#pragma mark - SettersAndGetters
- (NSMutableDictionary<NSString * ,id> *)blockDic{
    if (!_blockDic) {
        _blockDic = [NSMutableDictionary dictionary];
    }
    return _blockDic;
}

@end
