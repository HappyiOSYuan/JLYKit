//
//  NDBBaseViewModel.h
//  iShopManagement2.0
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 ningyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JLYKit/JLYURLRouter.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^JLYCompletionHandler)(id _Nullable obj ,  NSError * _Nullable  error);

@interface JLYBaseViewModel : NSObject

@property (nonatomic ,strong ,nonnull) NSMutableDictionary<NSString * ,id>*blockDic;

- (void)handleDataWithParams:(nullable NSDictionary<NSString * ,id>*)params CompletionHandler:(nonnull JLYCompletionHandler)completionHandler;
- (void)handleMoreDataWithCompletionHandler:(nonnull JLYCompletionHandler)completionHandler;
- (void)openVCWithIdentifer:(NSString * _Nullable)identifer
                       andParam:(nullable NSDictionary<NSString * ,id>*)params;

@end
NS_ASSUME_NONNULL_END