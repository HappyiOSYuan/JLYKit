//
//  NDBLoggerConfiguration.m
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYLoggerConfiguration.h"

@implementation JLYLoggerConfiguration

- (void)configWithAppType:(JLYAppType)appType{
    switch (appType) {
        case JLYAppTypeManager:
            self.channelID = [JLYAppContext sharedInstance].channelID;
            self.appKey = @"appKey";
            self.logAppName = [JLYAppContext sharedInstance].appName;
            self.serviceType = kJLYServiceManager;
            self.sendLogMethod = @"admin.writeAppLog";
            self.sendActionMethod = @"admin.recordaction";
            self.sendLogKey = @"data";
            self.sendActionKey = @"action_note";
            break;
    }
}

@end
