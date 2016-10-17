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

- (NSArray *)jly_popToViewControllerWithClassName:(NSString*)className animated:(BOOL)animated;{
    return [self popToViewController:[self jly_findViewController:className] animated:YES];
}

@end