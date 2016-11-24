//
//  JLYInteractorIO.h
//  JLYKit
//
//  Created by 袁宁 on 2016/11/24.
//  Copyright © 2016年 HappyiOSYuan. All rights reserved.
//

#import <JLYKit/JLYBaseInteractorIO.h>

@protocol JLYInteractorInput <JLYBaseInteractorIO>

- (void)jly_doSomething;

@end

@protocol JLYInteractorOutput <JLYBaseInteractorIO>

@end
