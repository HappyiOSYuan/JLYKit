//
//  JLYBasePresenter.h
//  GenericFramework
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JLYBaseVCModuleProtocol.h"
#import "JLYBaseInteractorIO.h"

#define JLYRealProtocol(nowPort,oldPort) ((nowPort)(oldPort))
#define JLYConvertInteractorToProtocol(protocol) JLYRealProtocol(protocol, self.interactor)
#define JLYConvertRoutingToProtocol(protocol) JLYRealProtocol(protocol, self.router)

NS_ASSUME_NONNULL_BEGIN
@interface JLYBasePresenter : NSObject<JLYBaseVCModuleProtocol>

@property (nonatomic, strong, readonly) id router;
@property (nonatomic, strong, readonly, nullable) id<JLYBaseInteractorIO>interactor;
@property (nonatomic, weak, readonly) UIViewController<JLYBaseVCModuleProtocol> *userInterface;

@end
NS_ASSUME_NONNULL_END
