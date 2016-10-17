//
//  NDBCachedObject.m
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYCachedObject.h"
#import "JLYNetworkingConfiguration.h"

@interface JLYCachedObject ()

@property (nonatomic, copy, readwrite) NSData *content;
@property (nonatomic, copy, readwrite) NSDate *lastUpdateTime;

@end

@implementation JLYCachedObject
#pragma mark - getters and setters
- (BOOL)isEmpty{
    return self.content == nil;
}

- (BOOL)isOutdated{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastUpdateTime];
    return timeInterval > kJLYCacheOutdateTimeSeconds;
}

- (void)setContent:(NSData *)content{
    _content = [content copy];
    self.lastUpdateTime = [NSDate dateWithTimeIntervalSinceNow:0];
}

#pragma mark - life cycle
- (instancetype)initWithContent:(NSData *)content{
    self = [super init];
    if (self) {
        self.content = content;
    }
    return self;
}

#pragma mark - public method
- (void)updateContent:(NSData *)content{
    self.content = content;
}

@end
