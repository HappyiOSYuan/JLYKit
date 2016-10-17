//
//  UIScrollView+EmptyDataSet.m
//  JLYEmptyDataSet
//  https://github.com/dzenbot/JLYEmptyDataSet
//
//  Created by Ignacio Romero Zurbuchen on 6/20/14.
//  Copyright (c) 2014 NY Labs. All rights reserved.
//  Licence: MIT-Licence
//

#import "UIScrollView+EmptyDataSet.h"
#import <objc/runtime.h>

@interface JLYEmptyDataSetView : UIView

@property (nonatomic, readonly) UIView *contentView;
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UILabel *detailLabel;
@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, readonly) UIButton *button;
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@property (nonatomic, assign) CGPoint offset;
@property (nonatomic, assign) CGFloat verticalSpace;

- (void)removeAllSubviews;

@end

#pragma mark - UIScrollView+EmptyDataSet

static char const * const kEmptyDataSetSource =     "emptyDataSetSource";
static char const * const kEmptyDataSetDelegate =   "emptyDataSetDelegate";
static char const * const kEmptyDataSetView =       "emptyDataSetView";

@interface UIScrollView () <UIGestureRecognizerDelegate>
@property (nonatomic, readonly) JLYEmptyDataSetView *emptyDataSetView;
@end

@implementation UIScrollView (JLYEmptyDataSet)

#pragma mark - Getters (Public)
- (id<JLYEmptyDataSetSource>)emptyDataSetSource{
    return objc_getAssociatedObject(self, kEmptyDataSetSource);
}

- (id<JLYEmptyDataSetDelegate>)emptyDataSetDelegate{
    return objc_getAssociatedObject(self, kEmptyDataSetDelegate);
}

- (BOOL)isEmptyDataSetVisible{
    UIView *view = objc_getAssociatedObject(self, kEmptyDataSetView);
    return view ? !view.hidden : NO;
}
#pragma mark - Getters (Private)
- (JLYEmptyDataSetView *)emptyDataSetView{
    JLYEmptyDataSetView *view = objc_getAssociatedObject(self, kEmptyDataSetView);
    
    if (!view){
        view = [JLYEmptyDataSetView new];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        view.hidden = YES;
        
        view.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ndb_didTapContentView:)];
        view.tapGesture.delegate = self;
        [view addGestureRecognizer:view.tapGesture];

        [self setEmptyDataSetView:view];
    }
    return view;
}

- (BOOL)ndb_canDisplay{
    if ([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]] || [self isKindOfClass:[UIScrollView class]])
    {
        id source = self.emptyDataSetSource;
        
        if (source && [source conformsToProtocol:@protocol(JLYEmptyDataSetSource)]) {
            return YES;
        }
        else {
            return NO;
        }
    }
    return NO;
}

- (NSInteger)ndb_itemsCount{
    NSInteger items = 0;
    
    if (![self respondsToSelector:@selector(dataSource)]) {
        return items;
    }
    
    if ([self isKindOfClass:[UITableView class]]) {
        
        id <UITableViewDataSource> dataSource = [self performSelector:@selector(dataSource)];
        UITableView *tableView = (UITableView *)self;
        
        NSInteger sections = 1;
        if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            sections = [dataSource numberOfSectionsInTableView:tableView];
        }
        
        for (NSInteger i = 0; i < sections; i++) {
            items += [dataSource tableView:tableView numberOfRowsInSection:i];
        }
    }
    else if ([self isKindOfClass:[UICollectionView class]]) {
        
        id <UICollectionViewDataSource> dataSource = [self performSelector:@selector(dataSource)];
        UICollectionView *collectionView = (UICollectionView *)self;
        
        NSInteger sections = 1;
        if ([dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
            sections = [dataSource numberOfSectionsInCollectionView:collectionView];
        }
        
        for (NSInteger i = 0; i < sections; i++) {
            items += [dataSource collectionView:collectionView numberOfItemsInSection:i];
        }
    }
    
    return items;
}


#pragma mark - Data Source Getters

- (NSAttributedString *)ndb_titleLabelText{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(ndb_titleForEmptyDataSet:)]) {
        NSAttributedString *string = [self.emptyDataSetSource ndb_titleForEmptyDataSet:self];
        if (string) NSAssert([string isKindOfClass:[NSAttributedString class]], @"You must return a valid NSAttributedString object -titleForEmptyDataSet:");
        return string;
    }
    return nil;
}

- (NSAttributedString *)ndb_detailLabelText{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(ndb_descriptionForEmptyDataSet:)]) {
        NSAttributedString *string = [self.emptyDataSetSource ndb_descriptionForEmptyDataSet:self];
        if (string) NSAssert([string isKindOfClass:[NSAttributedString class]], @"You must return a valid NSAttributedString object -descriptionForEmptyDataSet:");
        return string;
    }
    return nil;
}

- (UIImage *)ndb_image{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(ndb_imageForEmptyDataSet:)]) {
        UIImage *image = [self.emptyDataSetSource ndb_imageForEmptyDataSet:self];
        if (image) NSAssert([image isKindOfClass:[UIImage class]], @"You must return a valid UIImage object for -imageForEmptyDataSet:");
        return image;
    }
    return nil;
}

- (UIColor *)ndb_imageTintColor{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(ndb_imageTintColorForEmptyDataSet:)]) {
        UIColor *color = [self.emptyDataSetSource ndb_imageTintColorForEmptyDataSet:self];
        if (color) NSAssert([color isKindOfClass:[UIColor class]], @"You must return a valid UIColor object -imageTintColorForEmptyDataSet:");
        return color;
    }
    return nil;
}

- (NSAttributedString *)ndb_buttonTitleForState:(UIControlState)state{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(ndb_buttonTitleForEmptyDataSet:forState:)]) {
        NSAttributedString *string = [self.emptyDataSetSource ndb_buttonTitleForEmptyDataSet:self forState:state];
        if (string) NSAssert([string isKindOfClass:[NSAttributedString class]], @"You must return a valid NSAttributedString object for -buttonTitleForEmptyDataSet:forState:");
        return string;
    }
    return nil;
}

- (UIImage *)ndb_buttonBackgroundImageForState:(UIControlState)state{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(ndb_buttonBackgroundImageForEmptyDataSet:forState:)]) {
        UIImage *image = [self.emptyDataSetSource ndb_buttonBackgroundImageForEmptyDataSet:self forState:state];
        if (image) NSAssert([image isKindOfClass:[UIImage class]], @"You must return a valid UIImage object for -buttonBackgroundImageForEmptyDataSet:forState:");
        return image;
    }
    return nil;
}

- (UIColor *)ndb_dataSetBackgroundColor{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(ndb_backgroundColorForEmptyDataSet:)]) {
        UIColor *color = [self.emptyDataSetSource ndb_backgroundColorForEmptyDataSet:self];
        if (color) NSAssert([color isKindOfClass:[UIColor class]], @"You must return a valid UIColor object -backgroundColorForEmptyDataSet:");
        return color;
    }
    return [UIColor clearColor];
}

- (UIView *)ndb_customView{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(ndb_customViewForEmptyDataSet:)]) {
        UIView *view = [self.emptyDataSetSource ndb_customViewForEmptyDataSet:self];
        if (view) NSAssert([view isKindOfClass:[UIView class]], @"You must return a valid UIView object for -customViewForEmptyDataSet:");
        return view;
    }
    return nil;
}

- (CGPoint)ndb_offset{
    CGFloat top = roundf(self.contentInset.top / 2.0);
    CGFloat left = roundf(self.contentInset.left / 2.0);
    CGFloat bottom = roundf(self.contentInset.bottom / 2.0);
    CGFloat right = roundf(self.contentInset.right / 2.0);
    
    // Honors the scrollView's contentInset
    CGPoint offset = CGPointMake(left-right, top-bottom);
    
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(ndb_offsetForEmptyDataSet:)]) {
        CGPoint customOffset = [self.emptyDataSetSource ndb_offsetForEmptyDataSet:self];
        offset = CGPointMake(offset.x + customOffset.x, offset.y + customOffset.y);
    }
    
    return offset;
}

- (CGFloat)ndb_verticalSpace{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(ndb_spaceHeightForEmptyDataSet:)]) {
        return [self.emptyDataSetSource ndb_spaceHeightForEmptyDataSet:self];
    }
    return 0.0;
}
#pragma mark - Delegate Getters & Events (Private)
- (BOOL)ndb_shouldDisplay{
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(ndb_emptyDataSetShouldDisplay:)]) {
        return [self.emptyDataSetDelegate ndb_emptyDataSetShouldDisplay:self];
    }
    return YES;
}

- (BOOL)ndb_isTouchAllowed{
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(ndb_emptyDataSetShouldAllowTouch:)]) {
        return [self.emptyDataSetDelegate ndb_emptyDataSetShouldAllowTouch:self];
    }
    return YES;
}

- (BOOL)ndb_isScrollAllowed{
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(ndb_emptyDataSetShouldAllowScroll:)]) {
        return [self.emptyDataSetDelegate ndb_emptyDataSetShouldAllowScroll:self];
    }
    return NO;
}

- (void)ndb_willAppear{
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(ndb_emptyDataSetWillAppear:)]) {
        [self.emptyDataSetDelegate ndb_emptyDataSetWillAppear:self];
    }
}

- (void)ndb_didAppear{
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(ndb_emptyDataSetDidAppear:)]) {
        [self.emptyDataSetDelegate ndb_emptyDataSetDidAppear:self];
    }
}

- (void)ndb_willDisappear{
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(ndb_emptyDataSetWillDisappear:)]) {
        [self.emptyDataSetDelegate ndb_emptyDataSetWillDisappear:self];
    }
}

- (void)ndb_didTapContentView:(id)sender{
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(ndb_emptyDataSetDidTapView:)]) {
        [self.emptyDataSetDelegate ndb_emptyDataSetDidTapView:self];
    }
}

- (void)ndb_didTapDataButton:(id)sender{
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(ndb_emptyDataSetDidTapButton:)]) {
        [self.emptyDataSetDelegate ndb_emptyDataSetDidTapButton:self];
    }
}


#pragma mark - Setters (Public)

- (void)setEmptyDataSetSource:(id<JLYEmptyDataSetSource>)source{
    // Registers for device orientation changes
    if (source && !self.emptyDataSetSource) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidChangeOrientation:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    else if (!source && self.emptyDataSetSource) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    
    objc_setAssociatedObject(self, kEmptyDataSetSource, source, OBJC_ASSOCIATION_ASSIGN);
    
    if (![self ndb_canDisplay]) {
        return;
    }
    
    // We add method sizzling for injecting -ndb_reloadData implementation to the native -reloadData implementation
    [self swizzle:@selector(reloadData)];
    
    // If UITableView, we also inject -ndb_reloadData to -endUpdates
    if ([self isKindOfClass:[UITableView class]]) {
        [self swizzle:@selector(endUpdates)];
    }
}

- (void)setEmptyDataSetDelegate:(id<JLYEmptyDataSetDelegate>)delegate{
    objc_setAssociatedObject(self, kEmptyDataSetDelegate, delegate, OBJC_ASSOCIATION_ASSIGN);
    
    if (!delegate) {
        [self ndb_invalidate];
    }
}
#pragma mark - Setters (Private)
- (void)setEmptyDataSetView:(JLYEmptyDataSetView *)view{
    objc_setAssociatedObject(self, kEmptyDataSetView, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - Reload APIs (Public)
- (void)reloadEmptyDataSet{
    [self ndb_reloadEmptyDataSet];
}
#pragma mark - Reload APIs (Private)
- (void)ndb_reloadEmptyDataSet{
    if (![self ndb_canDisplay]) {
        return;
    }
    
    if ([self ndb_shouldDisplay] && [self ndb_itemsCount] == 0)
    {
        // Notifies that the empty dataset view will appear
        [self ndb_willAppear];
        
        JLYEmptyDataSetView *view = self.emptyDataSetView;
        UIView *customView = [self ndb_customView];
        
        if (!view.superview) {

            // Send the view to back, in case a header and/or footer is present
            if (([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]]) && self.subviews.count > 1) {
                [self insertSubview:view atIndex:1];
            }
            else {
                [self addSubview:view];
            }
        }
        
        // Moves all its subviews
        [view removeAllSubviews];
        
        // If a non-nil custom view is available, let's configure it instead
        if (customView) {
            view.customView = customView;
        }
        else {
            // Configure labels
            view.detailLabel.attributedText = [self ndb_detailLabelText];
            view.titleLabel.attributedText = [self ndb_titleLabelText];
            
            // Configure imageview
            UIColor *tintColor = [self ndb_imageTintColor];
            UIImage *image = [self ndb_image];
            UIImageRenderingMode renderingMode = tintColor ? UIImageRenderingModeAlwaysTemplate : UIImageRenderingModeAlwaysOriginal;
            
            view.imageView.image = [image imageWithRenderingMode:renderingMode];
            view.imageView.tintColor = tintColor;
            
            // Configure button
            [view.button setAttributedTitle:[self ndb_buttonTitleForState:UIControlStateNormal] forState:UIControlStateNormal];
            [view.button setAttributedTitle:[self ndb_buttonTitleForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
            [view.button setBackgroundImage:[self ndb_buttonBackgroundImageForState:UIControlStateNormal] forState:UIControlStateNormal];
            [view.button setBackgroundImage:[self ndb_buttonBackgroundImageForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];

            // Configure spacing
            view.verticalSpace = [self ndb_verticalSpace];
        }
        
        // Configure Offset
        view.offset = [self ndb_offset];
        
        // Configure the empty dataset view
        view.backgroundColor = [self ndb_dataSetBackgroundColor];
        view.hidden = NO;
        
        [view updateConstraints];
        [view layoutIfNeeded];
        
        // Configure scroll permission
        self.scrollEnabled = [self ndb_isScrollAllowed];

        // Configure empty dataset userInteraction permission
        view.userInteractionEnabled = [self ndb_isTouchAllowed];

        // Notifies that the empty dataset view did appear
        [self ndb_didAppear];
    }
    else if (self.isEmptyDataSetVisible) {
        [self ndb_invalidate];
    }
}

- (void)ndb_invalidate{
    // Notifies that the empty dataset view will disappear
    [self ndb_willDisappear];

    if (self.emptyDataSetView) {
        [self.emptyDataSetView removeAllSubviews];
        [self.emptyDataSetView removeFromSuperview];
        
        [self setEmptyDataSetView:nil];
    }
    
    self.scrollEnabled = YES;
}
#pragma mark - Notification Events
- (void)deviceDidChangeOrientation:(NSNotification *)notification{
    if (self.isEmptyDataSetVisible) {
        [self.emptyDataSetView updateConstraints];
        [self.emptyDataSetView layoutIfNeeded];
    }
}
#pragma mark - Method Swizzling
static NSMutableDictionary *_impLookupTable;
static NSString *const NYSwizzleInfoPointerKey = @"pointer";
static NSString *const NYSwizzleInfoOwnerKey = @"owner";
static NSString *const NYSwizzleInfoSelectorKey = @"selector";

// Based on Bryce Buchanan's swizzling technique http://blog.newrelic.com/2014/04/16/right-way-to-swizzle/
// And Juzzin's ideas https://github.com/juzzin/JUSEmptyViewController

void ndb_original_implementation(id self, SEL _cmd){
    // Fetch original implementation from lookup table
    NSString *key = ndb_implementationKey(self, _cmd);
    
    NSDictionary *swizzleInfo = [_impLookupTable objectForKey:key];
    NSValue *impValue = [swizzleInfo valueForKey:NYSwizzleInfoPointerKey];
    
    IMP impPointer = [impValue pointerValue];
    
    // We then inject the additional implementation for reloading the empty dataset
    // Doing it before calling the original implementation does update the 'isEmptyDataSetVisible' flag on time.
    [self ndb_reloadEmptyDataSet];

    // If found, call original implementation
    if (impPointer) {
        ((void(*)(id,SEL))impPointer)(self,_cmd);
    }
}

NSString *ndb_implementationKey(id target, SEL selector){
    if (!target || !selector) {
        return nil;
    }
    
    Class baseClass;
    if ([target isKindOfClass:[UITableView class]]) baseClass = [UITableView class];
    else if ([target isKindOfClass:[UICollectionView class]]) baseClass = [UICollectionView class];
    else return nil;
    
    NSString *className = NSStringFromClass([baseClass class]);
    
    NSString *selectorName = NSStringFromSelector(selector);
    return [NSString stringWithFormat:@"%@_%@",className,selectorName];
}


- (void)swizzle:(SEL)selector{
    // Check if the target responds to selector
    if (![self respondsToSelector:selector]) {
        return;
    }
    
    // Create the lookup table
    if (!_impLookupTable) {
        _impLookupTable = [[NSMutableDictionary alloc] initWithCapacity:2];
    }
    
    // We make sure that setImplementation is called once per class kind, UITableView or UICollectionView.
    for (NSDictionary *info in [_impLookupTable allValues]) {
        Class class = [info objectForKey:NYSwizzleInfoOwnerKey];
        NSString *selectorName = [info objectForKey:NYSwizzleInfoSelectorKey];
        
        if ([selectorName isEqualToString:NSStringFromSelector(selector)]) {
            if ([self isKindOfClass:class]) {
                return;
            }
        }
    }
    
    NSString *key = ndb_implementationKey(self, selector);
    NSValue *impValue = [[_impLookupTable objectForKey:key] valueForKey:NYSwizzleInfoPointerKey];
    
    // If the implementation for this class already exist, skip!!
    if (impValue) {
        return;
    }
    
    // Swizzle by injecting additional implementation
    Method method = class_getInstanceMethod([self class], selector);
    IMP ndb_newImplementation = method_setImplementation(method, (IMP)ndb_original_implementation);
    
    // Store the new implementation in the lookup table
    NSDictionary *swizzledInfo = @{NYSwizzleInfoOwnerKey: [self class],
                                   NYSwizzleInfoSelectorKey: NSStringFromSelector(selector),
                                   NYSwizzleInfoPointerKey: [NSValue valueWithPointer:ndb_newImplementation]};
    
    [_impLookupTable setObject:swizzledInfo forKey:key];
}


#pragma mark - UIGestureRecognizerDelegate Methods

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer.view isEqual:self.emptyDataSetView]) {
        return [self ndb_isTouchAllowed];
    }
    
    return [super gestureRecognizerShouldBegin:gestureRecognizer];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    UIGestureRecognizer *tapGesture = self.emptyDataSetView.tapGesture;

    if ([gestureRecognizer isEqual:tapGesture] || [otherGestureRecognizer isEqual:tapGesture]) {
        return YES;
    }

    // defer to emptyDataSetDelegate's implementation if available
    if ([self.emptyDataSetDelegate respondsToSelector:@selector(gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)]) {
        return [(id)self.emptyDataSetDelegate gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    }
    
    return NO;
}


@end


#pragma mark - JLYEmptyDataSetView

@interface JLYEmptyDataSetView ()
@end

@implementation JLYEmptyDataSetView
@synthesize contentView = _contentView;
@synthesize titleLabel = _titleLabel, detailLabel = _detailLabel, imageView = _imageView, button = _button;

#pragma mark - Initialization Methods

- (instancetype)init{
    self =  [super init];
    if (self) {
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)didMoveToSuperview{
    self.frame = self.superview.bounds;
    
    [UIView animateWithDuration:0.25
                     animations:^{_contentView.alpha = 1.0;}
                     completion:NULL];
}

#pragma mark - Getters
- (UIView *)contentView{
    if (!_contentView){
        _contentView = ({
           UIView *view = [UIView new];
            view.translatesAutoresizingMaskIntoConstraints = NO;
            view.backgroundColor = [UIColor clearColor];
            view.userInteractionEnabled = YES;
            view.alpha = 0;
            view;
        });
    }
    return _contentView;
}

- (UIImageView *)imageView{
    if (!_imageView){
        _imageView = ({
            UIImageView *imageView = [UIImageView new];
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
            imageView.backgroundColor = [UIColor clearColor];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.userInteractionEnabled = NO;
            imageView.accessibilityLabel = @"empty set background image";
            [self.contentView addSubview:imageView];
            imageView;
        });
        
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = ({
            UILabel *label = [UILabel new];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:27.0];
            label.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
            label.textAlignment = NSTextAlignmentCenter;
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 2;
            label.accessibilityLabel = @"empty set title";
            [self.contentView addSubview:label];
            label;
        });
        
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel){
        _detailLabel = ({
            UILabel *label = [UILabel new];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:17.0];
            label.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
            label.textAlignment = NSTextAlignmentCenter;
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 0;
            label.accessibilityLabel = @"empty set detail label";
            [self.contentView addSubview:label];
            label;
        });
        
    }
    return _detailLabel;
}

- (UIButton *)button{
    if (!_button){
        _button = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            btn.backgroundColor = [UIColor clearColor];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            btn.accessibilityLabel = @"empty set button";
            [btn addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn];
            btn;
        });
        
    }
    return _button;
}

- (BOOL)canShowImage {
    return (_imageView.image && _imageView.superview);
}

- (BOOL)canShowTitle {
    return (_titleLabel.attributedText.string.length > 0 && _titleLabel.superview);
}

- (BOOL)canShowDetail {
    return (_detailLabel.attributedText.string.length > 0 && _detailLabel.superview);
}

- (BOOL)canShowButton {
    return ([_button attributedTitleForState:UIControlStateNormal].string.length > 0 && _button.superview);
}
#pragma mark - Setters
- (void)setCustomView:(UIView *)view{
    if (!view) {
        return;
    }
    
    if (_customView) {
        [_customView removeFromSuperview];
        _customView = nil;
    }
    
    _customView = view;
    _customView.translatesAutoresizingMaskIntoConstraints = !CGRectIsEmpty(view.frame);
    [self.contentView addSubview:_customView];
}
#pragma mark - Action Methods
- (void)didTapButton:(id)sender{
    SEL selector = NSSelectorFromString(@"ndb_didTapDataButton:");
    
    if ([self.superview respondsToSelector:selector]) {
        [self.superview performSelector:selector withObject:sender afterDelay:0.0f];
    }
}

- (void)removeAllSubviews{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _titleLabel = nil;
    _detailLabel = nil;
    _imageView = nil;
    _button = nil;
    _customView = nil;
}

- (void)removeAllConstraints{
    [self removeConstraints:self.constraints];
    [_contentView removeConstraints:_contentView.constraints];
}
#pragma mark - UIView Constraints & Layout Methods
- (void)updateConstraintsIfNeeded{
    [super updateConstraintsIfNeeded];
}

- (void)updateConstraints{
    // Cleans up any constraints
    [self removeAllConstraints];
    
    NSMutableDictionary *views = [NSMutableDictionary dictionary];
    
    [views setObject:self forKey:@"self"];
    [views setObject:self.contentView forKey:@"contentView"];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[self]-(<=0)-[contentView]"
                                                                 options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self]-(<=0)-[contentView]"
                                                                 options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    
    // If a custom offset is available, we modify the contentView's constraints constants
    if (!CGPointEqualToPoint(self.offset, CGPointZero) && self.constraints.count == 4) {
        NSLayoutConstraint *vConstraint = self.constraints[1];
        NSLayoutConstraint *hConstraint = [self.constraints lastObject];
        
        // the values must be inverted to follow the up-bottom and left-right directions
        vConstraint.constant = self.offset.y*-1;
        hConstraint.constant = self.offset.x*-1;
    }
    
    if (_customView) {
        [views setObject:_customView forKey:@"customView"];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[customView]|" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[customView]|" options:0 metrics:nil views:views]];
        
        // Skips from any further configuration
        return [super updateConstraints];;
    }
    
    CGFloat width = CGRectGetWidth(self.frame) ? : CGRectGetWidth([UIScreen mainScreen].bounds);
    NSNumber *padding =  [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? @20 : @(roundf(width/16.0));
    NSNumber *imgWidth = @(roundf(_imageView.image.size.width));
    NSNumber *imgHeight = @(roundf(_imageView.image.size.height));
    NSNumber *trailing = @(roundf((width-[imgWidth floatValue])/2.0));
    
    NSDictionary *metrics = NSDictionaryOfVariableBindings(padding,trailing,imgWidth,imgHeight);
    
    // Since any element could be missing from displaying, we need to create a dynamic string format
    NSMutableArray *verticalSubviews = [NSMutableArray new];
    
    // Assign the image view's horizontal constraints
    if (_imageView.superview) {
        [views setObject:_imageView forKey:@"imageView"];
        [verticalSubviews addObject:@"[imageView(imgHeight)]"];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-trailing-[imageView(imgWidth)]-trailing-|"
                                                                                 options:0 metrics:metrics views:views]];
    }
    
    // Assign the title label's horizontal constraints
    if ([self canShowTitle]) {
        [views setObject:_titleLabel forKey:@"titleLabel"];
        [verticalSubviews addObject:@"[titleLabel]"];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[titleLabel]-padding-|"
                                                                                 options:0 metrics:metrics views:views]];
    }
    // or removes from its superview
    else {
        [_titleLabel removeFromSuperview];
        _titleLabel = nil;
    }
    
    // Assign the detail label's horizontal constraints
    if ([self canShowDetail]) {
        [views setObject:_detailLabel forKey:@"detailLabel"];
        [verticalSubviews addObject:@"[detailLabel]"];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[detailLabel]-padding-|"
                                                                                 options:0 metrics:metrics views:views]];
    }
    // or removes from its superview
    else {
        [_detailLabel removeFromSuperview];
        _detailLabel = nil;
    }
    
    // Assign the button's horizontal constraints
    if ([self canShowButton]) {
        [views setObject:_button forKey:@"button"];
        [verticalSubviews addObject:@"[button]"];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[button]-padding-|"
                                                                                 options:0 metrics:metrics views:views]];
    }
    // or removes from its superview
    else {
        [_button removeFromSuperview];
        _button = nil;
    }
    

    // Build the string format for the vertical constraints, adding a margin between each element. Default is 11.
    NSString *verticalFormat = [verticalSubviews componentsJoinedByString:[NSString stringWithFormat:@"-(%.f)-", self.verticalSpace ?: 11]];
    
    // Assign the vertical constraints to the content view
    if (verticalFormat.length > 0) {
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|%@|", verticalFormat]
                                                                             options:0 metrics:metrics views:views]];
    }
    
    [super updateConstraints];
}

@end
