//
//  NDBBaseViewModel.m
//  iShopManagement2.0
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 ningyuan. All rights reserved.
//

#import "JLYBaseViewModel.h"

@implementation JLYBaseViewModel

- (void)handleDataWithParams:(NSDictionary<NSString *,id> *)params
           CompletionHandler:(JLYCompletionHandler)completionHandler{
    self.blockDic[@"completion"] = [completionHandler copy];
}

- (void)handleMoreDataWithCompletionHandler:(JLYCompletionHandler)completionHandler{
    self.blockDic[@"completion"] = [completionHandler copy];
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
