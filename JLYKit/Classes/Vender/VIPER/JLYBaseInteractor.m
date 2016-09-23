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
    self.blockDic[@"completion"] = [completionHandler copy];
}
#pragma mark - SettersAndGetters
- (NSMutableDictionary<NSString * ,id> *)blockDic{
    if (!_blockDic) {
        _blockDic = [NSMutableDictionary dictionaryWithCapacity:2];
    }
    return _blockDic;
}

@end
