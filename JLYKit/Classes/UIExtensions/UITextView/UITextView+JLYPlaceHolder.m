//
//  UITextView+JLYPlaceHolder.m
//  Pods
//
//  Created by mac on 16/9/19.
//
//

#import "UITextView+JLYPlaceHolder.h"
#import <objc/runtime.h>

static const char *jly_placeHolder = "jly_placeHolderTextView";

@implementation UITextView (JLYPlaceHolder)

- (UITextView *)jly_placeHolderTextView {
    return objc_getAssociatedObject(self, jly_placeHolder);
}

- (void)setJly_placeHolderTextView:(UITextView *)jly_placeHolderTextView {
    objc_setAssociatedObject(self, jly_placeHolder, jly_placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)jly_addPlaceHolder:(NSString *)placeHolder {
    if (![self jly_placeHolderTextView]) {
        self.delegate = self;
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setJly_placeHolderTextView:textView];
    }
}
# pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.jly_placeHolderTextView.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text && [textView.text isEqualToString:@""]) {
        self.jly_placeHolderTextView.hidden = NO;
    }
}

@end
