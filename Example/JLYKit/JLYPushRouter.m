//
//  JLYPushRouter.m
//  JLYKit
//
//  Created by 袁宁 on 2016/11/24.
//  Copyright © 2016年 HappyiOSYuan. All rights reserved.
//

#import "JLYPushRouter.h"
#import "JLYPushPresenter.h"
#import "JLYPushViewController.h"

@implementation JLYPushRouter

JLY_BuildMoudleWith_VPI(
                        JLY_Class(JLYPushViewController),
                        JLY_Class(JLYPushPresenter),
                        nil
                        );

- (instancetype)init{
    if (self = [super init]) {
        JLYPushViewController *vc = [[JLYPushViewController alloc] init];
        [self setValue:vc forKey:@"viewController"];
        [JLYURLRouter registerURLPattern:@"push" withHandler:^(NSDictionary<NSString *, id> *routerParameters){
            if (routerParameters) {
                [self.viewController setValue:routerParameters[JLYURLRouterParameterUserInfo] forKey:@"passParams"];
            }
            [[self rootNav] pushViewController:self.viewController animated:YES];
        }];
    }
    return self;
}

@end
