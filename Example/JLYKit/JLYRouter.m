//
//  JLYRouter.m
//  JLYKit
//
//  Created by 袁宁 on 2016/11/24.
//  Copyright © 2016年 HappyiOSYuan. All rights reserved.
//

#import "JLYRouter.h"
#import "JLYViewController.h"
#import "JLYPresenter.h"
#import "JLYInteractor.h"
#import "JLYPushRouter.h"
@implementation JLYRouter
JLY_BuildMoudleWith_VNPI(
                         JLY_Class(JLYViewController),
                         JLY_Class(JLYBaseNavigationController),
                         JLY_Class(JLYPresenter),
                         JLY_Class(JLYInteractor)
                         )
#pragma mark - LifeCycle
- (instancetype)init{
    if (self = [super init]) {
        JLYViewController *vc = [[JLYViewController alloc] init];
        [self setValue:vc forKey:@"viewController"];
        [JLYURLRouter registerURLPattern:@"url" withObjectHandler:^(NSDictionary<NSString *, id>* params){
            NSLog(@"222");
            return self.viewController;
        }];
    }
    return self;
}
#pragma mark - PublicMethod
- (void)pushVC:(NSDictionary<NSString *,id> *)params{
    JLY_OPENVC(JLYPushRouter, @"push", nil, {});
}

@end
