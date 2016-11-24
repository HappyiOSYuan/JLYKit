//
//  JLYInteractor.m
//  JLYKit
//
//  Created by 袁宁 on 2016/11/24.
//  Copyright © 2016年 HappyiOSYuan. All rights reserved.
//

#import "JLYInteractor.h"

@implementation JLYInteractor

- (void)jly_doSomething{
    [JLYConvertOutputToProtocol(id<JLYInteractorOutput>) callBackBeforeSuccess:@"callBack"];
}

@end
