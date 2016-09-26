//
//  NDBBaseViewModel.h
//  iShopManagement2.0
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 ningyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JLYKit/JLYURLRouter.h>

#define JLYVIEWMODELDATACOMPLETION @"completion"

NS_ASSUME_NONNULL_BEGIN
typedef void (^JLYCompletionHandler)(id _Nullable obj ,  NSError * _Nullable  error);

@interface JLYBaseViewModel : NSObject

@property (nonatomic ,strong) NSMutableDictionary<NSString * ,id>*blockDic;

- (void)handleDataWithParams:(nullable NSDictionary<NSString * ,id>*)params
           CompletionHandler:(JLYCompletionHandler)completionHandler;

- (void)handleDataWithIdentifer:(NSString * _Nullable)identifer
                         Params:(nullable NSDictionary<NSString * ,id>*)params
              CompletionHandler:(JLYCompletionHandler)completionHandler;

- (void)handleMoreDataWithCompletionHandler:(JLYCompletionHandler)completionHandler;
- (void)handleMoreDataWithIdentifer:(NSString * _Nullable)identifer
                  CompletionHandler:(JLYCompletionHandler)completionHandler;

- (void)blindHandleWithKey:(NSString *)key CompletionHandler:(JLYCompletionHandler)completionHandler;

- (void)openVCWithIdentifer:(NSString * _Nullable)identifer
                       andParam:(nullable NSDictionary<NSString * ,id>*)params;

@end
NS_ASSUME_NONNULL_END