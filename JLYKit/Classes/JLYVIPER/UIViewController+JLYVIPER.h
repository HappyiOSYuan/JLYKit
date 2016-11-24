//
//  UIViewController+JLYVIPER.h
//  Pods
//
//  Created by 袁宁 on 2016/11/24.
//
//

#import <UIKit/UIKit.h>
#import "JLYBaseVCModuleProtocol.h"

NS_ASSUME_NONNULL_BEGIN
@interface UIViewController (JLYVIPER)<JLYBaseVCModuleProtocol>

@property (nonatomic, strong, nullable) id<JLYBaseVCModuleProtocol>eventHandler;

@end
NS_ASSUME_NONNULL_END
