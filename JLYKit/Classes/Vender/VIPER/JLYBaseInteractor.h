//
//  JLYBaseInterector.h
//  GenericFramework
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JLYDATACOMPLETION @"completion"

NS_ASSUME_NONNULL_BEGIN
typedef void (^JLYCompletionHandler)(id _Nullable obj ,NSError * _Nullable error);

@interface JLYBaseInteractor : NSObject

@property (nonatomic, strong) NSMutableDictionary<NSString * ,id> *blockDic;

- (void)blindHandleWithCompletionHandler:(JLYCompletionHandler)completionHandler;
- (void)blindHandleWithKey:(NSString *)key CompletionHandler:(JLYCompletionHandler)completionHandler;

@end
NS_ASSUME_NONNULL_END