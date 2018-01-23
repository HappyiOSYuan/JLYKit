//
//  UIControl+JLYFixMultiClick.m
//  Pods
//
//  Created by mac on 16/9/14.
//
//

#import "UIControl+JLYFixMultiClick.h"
#import <objc/runtime.h>
#import <JLYKit/JLYMethodSwizzling.h>

@implementation UIControl (JLYFixMultiClick)

static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";

- (NSTimeInterval)jly_acceptEventTime{
    return  [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setJly_acceptEventTime:(NSTimeInterval)jly_acceptEventTime {
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(jly_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


// 在load时执行hook
+ (void)load {
    SwizzlingMethod(
                    self,
                    @selector(sendAction:to:forEvent:),
                    @selector(jly_sendAction:to:forEvent:)
                    );
}

- (void)jly_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
//    if ([NSStringFromClass([self class]) hasPrefix:@"JLYMaterial"]) {
//        self.jly_acceptEventTime = [NSDate date].timeIntervalSince1970;
//        [self jly_sendAction:action to:target forEvent:event];
//        return;
//    }
//
//    if ([NSDate date].timeIntervalSince1970 - self.jly_acceptEventTime < 0.5f) {
//        if (![NSStringFromClass([self class]) isEqualToString:@"UITabBarButton"]) {
//            return;
//        }
//    }
//    self.jly_acceptEventTime = [NSDate date].timeIntervalSince1970;
    
    [self jly_sendAction:action to:target forEvent:event];
}

@end
