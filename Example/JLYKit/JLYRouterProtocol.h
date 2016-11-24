//
//  JLYRouterProtocol.h
//  JLYKit
//
//  Created by 袁宁 on 2016/11/24.
//  Copyright © 2016年 HappyiOSYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JLYRouterProtocol <NSObject>

- (void)pushVC:(NSDictionary<NSString *, id> *)params;

@end
