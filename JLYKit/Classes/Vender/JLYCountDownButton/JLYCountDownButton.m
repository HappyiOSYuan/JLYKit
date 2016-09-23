//
//  JLYCountDownButton.m
//  PayTreasure2.0
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYCountDownButton.h"

static NSString *const JLYCountDownConstStartText = @"获取验证码";
static NSString *const JLYCountDownConstEndText = @"点击重新获取";

@interface JLYCountDownButton()
@property (nonatomic, assign) NSInteger totalSecond;
@property (nonatomic, strong, nullable) NSTimer *timer;
@end

@implementation JLYCountDownButton
#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitle:JLYCountDownConstStartText forState:UIControlStateNormal];
    }
    return self;
}
#pragma mark - PrivateMethod
- (void)start{
    [self setEnabled:NO];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stop{
    [self setEnabled:YES];
    self.totalSecond = self.second;
    
    if (self.timer) {
        if ([self.timer respondsToSelector:@selector(isValid)]) {
            if ([self.timer isValid]) {
                [self.timer invalidate];
                self.timer = nil;
            }
        }
    }
    
    [self setTitle:JLYCountDownConstEndText forState:UIControlStateNormal];
    [self setTitle:JLYCountDownConstEndText forState:UIControlStateDisabled];
}
#pragma mark - EventResponse
-(void)timerCountDown:(NSTimer *)theTimer {
    self.totalSecond--;
    
    if (self.totalSecond < 0) {
        [self stop];
    } else {
        NSString *title = [NSString stringWithFormat:@"剩余%ld秒",(long)self.totalSecond+1];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateDisabled];
    }
}
#pragma mark - SettersAndGetters
- (void)setSecond:(NSInteger)second{
    _second = second;
    _totalSecond = second;
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(timerCountDown:)
                                                userInfo:nil
                                                 repeats:YES];
    }
    return _timer;
}

@end


