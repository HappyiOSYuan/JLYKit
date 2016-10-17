//
//  NDBUDIDGenerator.h
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface JLYUDIDGenerator : NSObject

+ (instancetype)sharedInstance;

- (NSString *)UDID;
- (void)saveUDID:(NSString *)udid;

@end
NS_ASSUME_NONNULL_END
