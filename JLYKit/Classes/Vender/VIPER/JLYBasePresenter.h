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

NS_ASSUME_NONNULL_BEGIN
@interface JLYBasePresenter : NSObject<JLYBaseVCModuleProtocol>

@property (nonatomic, strong) UIViewController *userInterface;

@end
NS_ASSUME_NONNULL_END