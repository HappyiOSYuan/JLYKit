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
#define JLYConvertOutputToProtocol(protocol) JLYRealProtocol(protocol, self.output)

NS_ASSUME_NONNULL_BEGIN

@interface JLYBaseInteractor : NSObject<JLYBaseInteractorIO>

@property (nonatomic, strong) NSMutableDictionary<NSString * ,id> *blockDic;
@property (nonatomic, strong, nullable, readonly) id baseDAO;
@property (nonatomic, weak, readonly, nullable) id<JLYBaseInteractorIO>output;

- (void)blindHandleWithCompletionHandler:(JLYCompletionHandler)completionHandler;
- (void)blindHandleWithKey:(NSString *)key CompletionHandler:(JLYCompletionHandler)completionHandler;

@end
NS_ASSUME_NONNULL_END
