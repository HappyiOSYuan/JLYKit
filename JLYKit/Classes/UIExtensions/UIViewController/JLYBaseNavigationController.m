//
//  JLYBaseNavigationController.m
//  Pods
//
//  Created by mac on 16/9/14.
//
//

#import "JLYBaseNavigationController.h"

#define WeakObj(o) autoreleasepool{} __weak typeof(o) Weak##o = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = Weak##o;

typedef void (^JLYTransitionBlock)(void);

@interface JLYBaseNavigationController ()<UINavigationControllerDelegate> {
    BOOL _transitionInProgress;
    NSMutableArray *_peddingBlocks;
    CGFloat _systemVersion;
}

@end

@implementation JLYBaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    _transitionInProgress = NO;
    _peddingBlocks = [NSMutableArray arrayWithCapacity:2];
    _systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
}

#pragma mark - Pushing and Popping Stack Items

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (8.0 <= _systemVersion) {
        [super pushViewController:viewController animated:animated];
    }
    else {
        [self addTransitionBlock:^{
            [super pushViewController:viewController animated:animated];
        }];
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    UIViewController *poppedViewController = nil;
    if (8.0 <= _systemVersion) {
        poppedViewController = [super popViewControllerAnimated:animated];
    }
    else {
        @WeakObj(self);
        [self addTransitionBlock:^{
            UIViewController *viewController = [super popViewControllerAnimated:animated];
            if (viewController == nil) {
                Weakself.transitionInProgress = NO;
            }
        }];
    }
    return poppedViewController;
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSArray *poppedViewControllers = nil;
    if (8.0 <= _systemVersion) {
        poppedViewControllers = [super popToViewController:viewController animated:animated];
    }
    else {
        @WeakObj(self);
        [self addTransitionBlock:^{
            if ([Weakself.viewControllers containsObject:viewController]) {
                NSArray *viewControllers = [super popToViewController:viewController animated:animated];
                if (viewControllers.count == 0) {
                    Weakself.transitionInProgress = NO;
                }
            }
            else {
                Weakself.transitionInProgress = NO;
            }
        }];
    }
    return poppedViewControllers;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated{
    NSArray *poppedViewControllers = nil;
    if (8.0 <= _systemVersion) {
        poppedViewControllers = [super popToRootViewControllerAnimated:animated];
    }
    else {
        @WeakObj(self);
        [self addTransitionBlock:^{
            NSArray *viewControllers = [super popToRootViewControllerAnimated:animated];
            if (viewControllers.count == 0) {
                Weakself.transitionInProgress = NO;
            }
        }];
    }
    return poppedViewControllers;
}

#pragma mark - Accessing Items on the Navigation Stack

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated{
    if (8.0 <= _systemVersion) {
        [super setViewControllers:viewControllers animated:animated];
    }
    else {
        @WeakObj(self);
        [self addTransitionBlock:^{
            NSArray<UIViewController *> *originalViewControllers = Weakself.viewControllers;
            [super setViewControllers:viewControllers animated:animated];
            if (!animated || originalViewControllers.lastObject == viewControllers.lastObject) {
                Weakself.transitionInProgress = NO;
            }
        }];
    }
}

#pragma mark - Transition Manager

- (void)addTransitionBlock:(void (^)(void))block{
    if (![self isTransitionInProgress]) {
        self.transitionInProgress = YES;
        block();
    }
    else {
        [_peddingBlocks addObject:[block copy]];
    }
}

- (BOOL)isTransitionInProgress{
    return _transitionInProgress;
}

- (void)setTransitionInProgress:(BOOL)transitionInProgress{
    _transitionInProgress = transitionInProgress;
    if (!transitionInProgress && _peddingBlocks.count > 0) {
        _transitionInProgress = YES;
        [self runNextTransition];
    }
}

- (void)runNextTransition{
    JLYTransitionBlock block = _peddingBlocks.firstObject;
    [_peddingBlocks removeObject:block];
    block();
}

@end
