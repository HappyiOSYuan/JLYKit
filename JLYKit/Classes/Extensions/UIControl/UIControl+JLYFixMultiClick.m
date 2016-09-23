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

- (NSTimeInterval)cs_acceptEventTime {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setCs_acceptEventTime:(NSTimeInterval)cs_acceptEventTime {
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(cs_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


// 在load时执行hook
+ (void)load {
    SwizzlingMethod(
                    self,
                    @selector(sendAction:to:forEvent:),
                    @selector(cs_sendAction:to:forEvent:)
                    );
}

- (void)cs_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([NSDate date].timeIntervalSince1970 - self.cs_acceptEventTime < 1.0f) {
        return;
    }
    
    self.cs_acceptEventTime = [NSDate date].timeIntervalSince1970;
    
    [self cs_sendAction:action to:target forEvent:event];
}

@end
