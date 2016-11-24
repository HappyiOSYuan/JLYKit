//
//  UIViewController+JLYVIPER.m
//  Pods
//
//  Created by 袁宁 on 2016/11/24.
//
//

#import "UIViewController+JLYVIPER.h"
#import <objc/runtime.h>

static void *JLYViewControllerEventHandler = @"JLYViewControllerEventHandler";

@implementation UIViewController (JLYVIPER)
#pragma mark - LifeCycle
- (void)viewDidLoad{
    if (self.eventHandler) {
        [self.eventHandler jly_blindVC:self];
    }
}
#pragma mark - SettersAndGetters
- (void)setEventHandler:(id<JLYBaseVCModuleProtocol>)eventHandler{
    objc_setAssociatedObject(self, &JLYViewControllerEventHandler, eventHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<JLYBaseVCModuleProtocol>)eventHandler{
    return objc_getAssociatedObject(self, &JLYViewControllerEventHandler);
}

@end
