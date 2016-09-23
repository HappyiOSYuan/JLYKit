//
//  JLYBaseInterector.h
//  GenericFramework
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^JLYCompletionHandler)(id _Nullable obj ,NSError * _Nullable error);

@interface JLYBaseInteractor : NSObject

@property (nonatomic, strong) NSMutableDictionary<NSString * ,id> *blockDic;

- (void)blindHandleWithCompletionHandler:(nonnull JLYCompletionHandler)completionHandler;

@end
NS_ASSUME_NONNULL_END