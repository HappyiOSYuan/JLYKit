//
//  UIViewController+NDBAdditions.m
//  iShopManageMent
//
//  Created by TJBT on 15/9/25.
//  Copyright © 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "UIViewController+JLYAdditions.h"
#import <objc/runtime.h>

static void *NDBViewControllerPassParams;

@implementation UIViewController (JLYAdditions)

- (void)setPassParams:(NSDictionary<NSString *,id> *)passParams{
    objc_setAssociatedObject(self, &NDBViewControllerPassParams, passParams, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary<NSString *,id> *)passParams{
    return objc_getAssociatedObject(self, &NDBViewControllerPassParams);
}

- (void)setListDatasource:(NSMutableArray *)listDatasource{
    objc_setAssociatedObject(self, @selector(listDatasource), listDatasource, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableArray *)listDatasource{
    if (!objc_getAssociatedObject(self, _cmd)) {
        objc_setAssociatedObject(self, _cmd, [NSMutableArray array], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setIsLoading:(NSNumber *)isLoading{
    objc_setAssociatedObject(self, _cmd, [NSMutableArray array], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)isLoading{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)showHud:(NSString *)title{
    [SVProgressHUD showWithStatus:title];
}

- (void)dismissHud{
    [SVProgressHUD dismiss];
}

- (void)showErrorHud:(NSString *)errorInfo{
    [SVProgressHUD showErrorWithStatus:errorInfo];
}

- (void)showMessageSuccess:(NSString *)messege andInfo:(NSString *)info{
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@  %@" ,messege ,info ? : @""]];
    [SVProgressHUD dismissWithDelay:1.5f];
}

- (void)showMessageFailed:(NSString *)messege andInfo:(NSString *)info{
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@  %@" ,messege ,info ? : @""]];
    [SVProgressHUD dismissWithDelay:1.5f];
}

- (void)showMessageWarning:(NSString *)messege andInfo:(NSString *)info{
    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@  %@" ,messege ,info ? : @""]];
    [SVProgressHUD dismissWithDelay:1.5f];
}

@end

@implementation UINavigationController (ShouldPopOnBackButton)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [vc navigationShouldPopOnBackButton];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        [[navigationBar subviews] enumerateObjectsUsingBlock:^(UIView *subview ,NSUInteger idx ,BOOL *stop){
            if(0.0f < subview.alpha && subview.alpha < 1.0f) {
                [UIView animateWithDuration:0.25f animations:^{
                    subview.alpha = 1.0f;
                }];
            }
        }];
    }
    
    return NO;
}

@end
