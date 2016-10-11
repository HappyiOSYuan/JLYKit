//
//  UIViewController+JLYNavSafeTransation.m
//  Pods
//
//  Created by mac on 16/9/14.
//
//

#import "UIViewController+JLYNavSafeTransation.h"
#import "JLYBaseNavigationController.h"
#import "JLYMethodSwizzling.h"

@implementation UIViewController (JLYNavSafeTransation)

+ (void)load{
    SwizzlingMethod(self, @selector(viewDidAppear:), @selector(sofaViewDidAppear:));
}


- (void)sofaViewDidAppear:(BOOL)animated{
    if ([self.navigationController isKindOfClass:[JLYBaseNavigationController class]]) {
        self.navigationController.transitionInProgress = NO;
    }
    [self sofaViewDidAppear:animated];
}

@end
