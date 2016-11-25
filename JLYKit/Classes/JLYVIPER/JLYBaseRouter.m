//
//  JLYBaseRouter.m
//  iShopManagement2.0
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 ningyuan. All rights reserved.
//

#import "JLYBaseRouter.h"
#import "JLYAppDelegate+Method.h"
#import "JLYBasePresenter.h"
#import "JLYBaseInteractor.h"
#import "JLYBaseDAO.h"

@interface JLYBaseRouter ()
/**
 当前视图
 */
@property (nonatomic, strong) id<JLYBaseVCModuleProtocol> currentUserInterface;

/**
 当前导航
 */
@property (nonatomic, strong) UINavigationController *currentNavigator;

@end

@implementation JLYBaseRouter
@synthesize presenter = _presenter;
@synthesize viewController = _viewController;

#pragma mark - LifeCycle
+ (instancetype)routing{
    return [[self alloc] init];
}
#pragma mark - PublicMethod
- (void)jly_showRootViewControllerWithWindow:(UIWindow *)window{
    window.rootViewController = [self currentNavVC] ? : [self realVC];
    [window makeKeyAndVisible];
}

- (instancetype)jly_buildModulesWithVCClass:(Class)vcClass
                          navigationVCClass:(Class)navigationVCClass
                             PresenterClass:(Class)presenttClass
                            interactorClass:(Class)interactorClass
                                   daoClass:(Class)daoClass{
    return [self _buildModulesWithVCClass:vcClass
                        navigationVCClass:navigationVCClass
                           PresenterClass:presenttClass
                          interactorClass:interactorClass
                                 daoClass:daoClass];
}
#pragma mark - PrivateMethod
- (instancetype)_buildModulesWithVCClass:(Class)vcClass
                       navigationVCClass:(Class)navigationVCClass
                          PresenterClass:(Class)presentClass
                         interactorClass:(Class)interactorClass
                                daoClass:(Class)daoClass{
    if (vcClass == [self.viewController class]) {
        self.currentUserInterface = self.viewController;
        
        if (navigationVCClass) {
            self.currentNavigator = [[JLYBaseNavigationController alloc] initWithRootViewController:self.viewController];
        }
        
        if (presentClass) {
            JLYBasePresenter *basePresenter = [[presentClass alloc] init];
            [self.viewController setValue:basePresenter forKey:@"eventHandler"];
            [basePresenter setValue:self forKey:@"router"];
            [self setValue:basePresenter forKey:@"presenter"];
            
            if (interactorClass) {
                JLYBaseInteractor *baseInteractor = [[interactorClass alloc] init];
                [basePresenter setValue:baseInteractor forKey:@"interactor"];
                [baseInteractor setValue:basePresenter forKey:@"output"];
                
                if (daoClass) {
                    JLYBaseDAO *baseDAO = [[JLYBaseDAO alloc] init];
                    [baseInteractor setValue:baseDAO forKey:@"baseDAO"];
                }
            }
        }
    }
    return self;
}

// 移除当前路由对视图层的强引用
- (void)removePresenterForCurrentInterface{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (true) {
            // 当事件层能拿到视图时，立即释放对它的强引用
            if ([_presenter userInterface]) {
                self.currentUserInterface = nil;
                self.currentNavigator = nil;
                break;
            }
            sleep(1);
        }
    });
    
}
#pragma mark - SettersAndGetters
- (JLYBaseNavigationController *)rootNav{
    return (JLYBaseNavigationController *)[JLYAppDelegate appDelegate].window.rootViewController;
}

- (JLYBaseNavigationController *)currentNavVC{
    [self removePresenterForCurrentInterface];
    return self.currentNavigator ? : (JLYBaseNavigationController *)[[_presenter userInterface] navigationController];
}

- (__kindof id<JLYBaseVCModuleProtocol>)realVC{
    [self removePresenterForCurrentInterface];
    return self.currentUserInterface ? : [_presenter userInterface];
}

@end
