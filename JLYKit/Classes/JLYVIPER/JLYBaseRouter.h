//
//  JLYBaseRouter.h
//  iShopManagement2.0
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 ningyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JLYURLRouter.h"
#import "JLYBaseNavigationController.h"
#import "JLYBaseVCModuleProtocol.h"


//跳转页面
#define JLY_OPENVC(RouterClass, RouterURL, Params, customCode) \
RouterClass *router = [RouterClass routing]; \
NSAssert(router != nil, @"router不能为nil"); \
customCode \
[JLYURLRouter openURL:RouterURL withUserInfo:Params completion:nil];
//构建模块关系
#define JLY_BuildMoudleWith_VNPID(_vcClass_, _NAVClass_, _PresenterClass_, _InteractorClass_, _JLYDaoClass_) \
+ (instancetype)routing \
{ \
return [[super routing] jly_buildModulesWithVCClass:_vcClass_ \
                                  navigationVCClass:_NAVClass_ \
                                     PresenterClass:_PresenterClass_ \
                                    interactorClass:_InteractorClass_ \
                                           daoClass:_JLYDaoClass_]; \
}
//构建模块关系
#define JLY_BuildMoudleWith_VNPI(_vcClass_, _NAVClass_, _PresenterClass_, _InteractorClass_) \
JLY_BuildMoudleWith_VNPID(_vcClass_, _NAVClass_, _PresenterClass_, _InteractorClass_, nil)

#define JLY_BuildMoudleWith_VPID(_vcClass_, _PresenterClass_, _InteractorClass_, _JLYDaoClass_) \
JLY_BuildMoudleWith_VNPID(_vcClass_, nil, _PresenterClass_, _InteractorClass_, _JLYDaoClass_)

#define JLY_BuildMoudleWith_VPI(_vcClass_, _PresenterClass_, _InteractorClass_) \
JLY_BuildMoudleWith_VNPID(_vcClass_, nil, _PresenterClass_, _InteractorClass_, nil)

// 显示根模块
#define JLY_ShowRootWindow(RouterClass,customCode) \
RouterClass *router = [RouterClass routing]; \
NSAssert(router != nil, @"router不能为nil"); \
customCode \
[router jly_showRootViewControllerWithWindow:application.delegate.window];

@interface JLYBaseRouter : NSObject

@property (nonatomic, weak, readonly) id<JLYBaseVCModuleProtocol>presenter;
@property (nonatomic, strong, readonly) UIViewController *viewController;

/**
 *  组装当前路由
 *
 *  @return 路由
 */
+ (instancetype)routing;
- (JLYBaseNavigationController *)rootNav;
/**
 构建模块VIPER分层,vcClass的初始化工作应当在Router中完成

 @param vcClass 视图层
 @param navigationVCClass 导航层
 @param perstentClass 交互层
 @param interactorClass 业务层
 @param daoClass Dao层
 @return Router
 */
- (instancetype)jly_buildModulesWithVCClass:(Class)vcClass
                          navigationVCClass:(Class)navigationVCClass
                             PresenterClass:(Class)presenttClass
                            interactorClass:(Class)interactorClass
                                   daoClass:(Class)daoClass;


/**
 设置跟控制器

 @param window 程序主窗口
 */
- (void)jly_showRootViewControllerWithWindow:(UIWindow *)window;

@end
