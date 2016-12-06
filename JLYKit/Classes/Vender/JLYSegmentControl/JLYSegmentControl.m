//
//  JLYSegmentControl.m
//  CustomeSegmentControl
//
//  Created by 袁宁 on 2016/12/5.
//  Copyright © 2016年 zeluli. All rights reserved.
//

#import "JLYSegmentControl.h"

#define DEFAULT_TITLES_FONT 20.0f
#define DEFAULT_DURATION 3.0f

NS_ASSUME_NONNULL_BEGIN
@interface JLYSegmentControl ()

@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, assign) CGFloat labelWidth;

@property (nonatomic, strong) UIView *heightLightView;
@property (nonatomic, strong) UIView *heightTopView;
@property (nonatomic, strong) UIView *heightColoreView;

@property (nonatomic, strong) NSMutableArray<UILabel *> *labelMutableArray;
@property (nonatomic, copy) ClickBlock clickBlock;

@property (nonatomic, strong) UIButton *currentTapButton;

@end
NS_ASSUME_NONNULL_END

@implementation JLYSegmentControl
#pragma mark - LifeCycle
- (instancetype)init{
    if(self = [super init]){
        _duration = DEFAULT_DURATION;
    }
    return self;
}

- (void)layoutSubviews{
    _viewWidth = super.frame.size.width;
    _viewHeight = super.frame.size.height;
    self.layer.cornerRadius = self.frame.size.height / 2;
    
    [self removeAllSubView];
    
    
    [self customeData];
    [self createBottomLabels];
    [self createTopLables];
    [self createTopButtons];
    
    [self layoutIfNeeded];
    
    if (_currentTapButton) {
        [self tapButton:_currentTapButton];
    }

}
#pragma mark - PublicMethod
-(void)setButtonOnClickBlock:(ClickBlock)clickBlock{
    if (clickBlock) {
        _clickBlock = clickBlock;
    }
}
#pragma mark - EventResponse
- (void)tapButton:(UIButton *) sender{
    
    _currentTapButton = sender;
    if(_clickBlock && sender.tag < _titles.count){
        _clickBlock(sender.tag, _titles[sender.tag]);
    }
    
    CGRect frame = [self countCurrentRectWithIndex:sender.tag];
    CGRect changeFrame = [self countCurrentRectWithIndex:-sender.tag];
    
    [UIView animateWithDuration:_duration animations:^{
        _heightLightView.frame = frame;
        _heightTopView.frame = changeFrame;
    } completion:^(BOOL finished){
        [self shakeAnimationForView:_heightColoreView];
    }];
}

#pragma mark - PrivateMethod
- (void)customeData{
    if(!_titles){
        _titles = @[@"Section0", @"Section1", @"Section2", @"Section3"];
    }
    
    if(!_titlesCustomColor){
        _titlesCustomColor = [UIColor blackColor];
    }
    
    if(!_titlesHighlightColor){
        _titlesHighlightColor = [UIColor whiteColor];
    }
    
    if(!_backgroundHighlightColor){
        _backgroundHighlightColor = [UIColor redColor];
    }
    
    if(_titlesFont == nil){
        _titlesFont = [UIFont systemFontOfSize:DEFAULT_TITLES_FONT];
    }
    
    if(!_labelMutableArray){
        _labelMutableArray = [[NSMutableArray alloc] initWithCapacity:_titles.count];
    }
    _labelWidth = _viewWidth / _titles.count;
    
}

- (void)removeSubView:(UIView *)subView{
    [subView removeFromSuperview];
    subView = nil;
}

- (void)removeAllSubView{
    if(_heightColoreView){
        [self removeSubView:_heightLightView];
        [self removeSubView:_heightTopView];
        [self removeSubView:_heightColoreView];
        [self.labelMutableArray removeAllObjects];
        
        [self.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop){
            [view removeFromSuperview];
        }];
    }
}

- (CGRect)countCurrentRectWithIndex: (NSInteger) index{
    return  CGRectMake(_labelWidth * index, 0, _labelWidth, _viewHeight);
}

- (UILabel *)createLabelWithTitlesIndex:(NSInteger) index textColor:(UIColor *) textColor{
    CGRect currentLabelFrame = [self countCurrentRectWithIndex:index];
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:currentLabelFrame];
    tempLabel.textColor = textColor;
    tempLabel.text = _titles[index];
    tempLabel.font = _titlesFont;
    tempLabel.minimumScaleFactor = 0.1f;
    tempLabel.textAlignment = NSTextAlignmentCenter;
    return tempLabel;
}

- (void)createBottomLabels{
    [_titles enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop){
        UILabel *tempLabel = [self createLabelWithTitlesIndex:idx textColor:_titlesCustomColor];
        [self addSubview:tempLabel];
        [_labelMutableArray addObject:tempLabel];
    }];
}

- (void)createTopLables{
    CGRect heightLightViewFrame = CGRectMake(0.0f, 0.0f, _labelWidth, _viewHeight);
    _heightLightView = [[UIView alloc] initWithFrame:heightLightViewFrame];
    _heightLightView.clipsToBounds = YES;
    
    _heightColoreView = [[UIView alloc] initWithFrame:heightLightViewFrame];
    _heightColoreView.backgroundColor = _backgroundHighlightColor;
    _heightColoreView.layer.cornerRadius = self.frame.size.height / 2;
    _heightLightView.layer.borderColor = _titlesHighlightColor.CGColor;
    _heightLightView.layer.borderWidth = 2.0f;
    _heightLightView.backgroundColor = [UIColor whiteColor];
    _heightLightView.layer.cornerRadius = self.frame.size.height / 2;
    [_heightLightView addSubview:_heightColoreView];
    
    _heightTopView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, _viewWidth, _viewHeight)];
    [_titles enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop){
        UILabel *label = [self createLabelWithTitlesIndex:idx textColor:_titlesHighlightColor];
        [_heightTopView addSubview:label];
    }];
    [_heightLightView addSubview:_heightTopView];
    [self addSubview:_heightLightView];
}

- (void)createTopButtons{
    [_titles enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop){
        UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tempButton.frame = [self countCurrentRectWithIndex:idx];
        tempButton.tag = idx;
        [tempButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tempButton];
    }];
}

- (void)shakeAnimationForView:(UIView *)view{
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint x = CGPointMake(position.x + 1.0f, position.y);
    CGPoint y = CGPointMake(position.x - 1.0f, position.y);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:.06f];
    [animation setRepeatCount:3.0f];
    [viewLayer addAnimation:animation forKey:nil];
}
#pragma mark - SettersAndGetters

@end
