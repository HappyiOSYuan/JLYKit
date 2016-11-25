//
//  JLYBaseInterectorIO.h
//  GenericFramework
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JLYVIPERMacro.h"

NS_ASSUME_NONNULL_BEGIN

@protocol JLYBaseInteractorIO <NSObject>

- (void)callBackBeforeSuccess:(id _Nullable)obj;

@end
NS_ASSUME_NONNULL_END
