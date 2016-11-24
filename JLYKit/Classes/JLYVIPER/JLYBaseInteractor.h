//
//  JLYBaseInterector.h
//  GenericFramework
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JLYBaseInteractorIO.h"

#define JLYDATACOMPLETION @"completion"
#define JLYRealProtocol(nowPort,oldPort) ((nowPort)(oldPort))
#define JLYConvertOutputToProtocol(protocol) JLYRealProtocol(protocol, self.output)

NS_ASSUME_NONNULL_BEGIN
typedef void (^JLYCompletionHandler)(id _Nullable obj ,NSError * _Nullable error);

@class JLYBaseDAO;
@interface JLYBaseInteractor : NSObject<JLYBaseInteractorIO>

@property (nonatomic, strong) NSMutableDictionary<NSString * ,id> *blockDic;
@property (nonatomic, strong, nullable, readonly) JLYBaseDAO *baseDAO;
@property (nonatomic, weak, readonly) id<JLYBaseInteractorIO>output;

- (void)blindHandleWithCompletionHandler:(JLYCompletionHandler)completionHandler;
- (void)blindHandleWithKey:(NSString *)key CompletionHandler:(JLYCompletionHandler)completionHandler;

@end
NS_ASSUME_NONNULL_END
