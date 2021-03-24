//
//  UINavigationController+JLYStackManager.m
//  Pods
//
//  Created by mac on 16/9/19.
//
//

#import "UINavigationController+JLYStackManager.h"

@implementation UINavigationController (JLYStackManager)

- (id)jly_findViewController:(NSString*)className{
    NSAssert(className != nil, @"类名不能为空");
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(className)]) {
            return viewController;
        }
    }
    
    return nil;
}

- (UIViewController *)jly_rootViewController{
    if (self.viewControllers && [self.viewControllers count] >0) {
        return [self.viewControllers firstObject];
    }
    return nil;
}

- (NSArray<__kindof UIViewController *> *)jly_popToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated;{
    NSAssert(className != nil, @"类名不能为空");
    return [self popToViewController:[self jly_findViewController:className] animated:YES];
}

@end
