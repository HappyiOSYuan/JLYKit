//
//  NDBBaseViewModel.m
//  iShopManagement2.0
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 ningyuan. All rights reserved.
//

#import "JLYBaseViewModel.h"

@implementation JLYBaseViewModel

- (void)blindHandleWithKey:(NSString *)key CompletionHandler:(JLYCompletionHandler)completionHandler{
    self.blockDic[key] = [completionHandler copy];
}

- (void)handleDataWithParams:(NSDictionary<NSString *,id> *)params
           CompletionHandler:(JLYCompletionHandler)completionHandler{
    [self handleDataWithIdentifer:nil Params:params CompletionHandler:completionHandler];
}

- (void)handleDataWithIdentifer:(NSString *)identifer
                         Params:(NSDictionary<NSString *,id> *)params
              CompletionHandler:(JLYCompletionHandler)completionHandler{
    [self blindHandleWithKey:identifer ? : JLYVIEWMODELDATACOMPLETION  CompletionHandler:completionHandler];
}

- (void)handleMoreDataWithCompletionHandler:(JLYCompletionHandler)completionHandler{
    [self handleMoreDataWithIdentifer:nil CompletionHandler:completionHandler];
}

- (void)handleMoreDataWithIdentifer:(NSString *)identifer CompletionHandler:(JLYCompletionHandler)completionHandler{
    [self blindHandleWithKey:identifer ? : JLYVIEWMODELDATACOMPLETION CompletionHandler:completionHandler];
}

- (void)openVCWithIdentifer:(NSString *)identifer andParam:(NSDictionary<NSString *,id> *)params{
    
}

- (NSMutableDictionary<NSString * ,id>*)blockDic{
    if (!_blockDic) {
        _blockDic = [NSMutableDictionary dictionary];
    }
    return _blockDic;
}

@end
