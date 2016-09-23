//
//  JLYBaseVCModuleProtocol.h
//  GenericFramework
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^JLYCompletionHandler)(id _Nullable obj ,NSError * _Nullable error);

@protocol JLYBaseVCModuleProtocol <NSObject>

- (void)jly_handleDataWithIdentifer:(NSString *)identifer
                          andParams:(NSDictionary<NSString * ,id> *)params
                  CompletionHandler:(nonnull JLYCompletionHandler)completionHandler;
@optional
- (void)jly_handleMoreDataWithIdentifer:(NSString *)identifer
                              andParams:(NSDictionary<NSString * ,id> *)params
                      CompletionHandler:(nonnull JLYCompletionHandler)completionHandler;

- (void)jly_openVCWithIdentifer:(NSString *)identifer
                       andParam:(NSDictionary<NSString * ,id> *)params;

- (void)jly_dissmissVC;
- (void)jly_popVC;
- (NSArray<UIViewController *> *)jly_listViewControllers;

@end
NS_ASSUME_NONNULL_END