//
//  JLYBaseVCModuleProtocol.h
//  GenericFramework
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JLYVIPERMacro.h"

NS_ASSUME_NONNULL_BEGIN

@protocol JLYBaseVCModuleProtocol <NSObject>

@property (nonatomic, weak, readonly) UIViewController<JLYBaseVCModuleProtocol> *userInterface;


- (void)jly_blindVC:(__kindof UIViewController<JLYBaseVCModuleProtocol> *)viewController;

- (void)jly_handleDataWithIdentifer:(NSString * _Nullable)identifer
                          andParams:(NSDictionary<NSString * ,id> * _Nullable)params
                  CompletionHandler:(JLYCompletionHandler)completionHandler;
@optional
- (void)jly_handleMoreDataWithIdentifer:(NSString * _Nullable)identifer
                              andParams:(NSDictionary<NSString * ,id> * _Nullable)params
                      CompletionHandler:(JLYCompletionHandler)completionHandler;

- (void)jly_openVCWithIdentifer:(NSString * _Nullable)identifer
                       andParam:(NSDictionary<NSString * ,id>* _Nullable)params;

- (void)jly_dissmissVC;
- (void)jly_popVC;
- (NSArray<__kindof UIViewController *> *)jly_listViewControllers;

@end

NS_ASSUME_NONNULL_END
