//
//  JLYDatePickerView.m
//  CustomeSegmentControl
//
//  Created by 袁宁 on 2016/12/5.
//  Copyright © 2016年 zeluli. All rights reserved.
//

#import "JLYDatePickerView.h"
#import <JLYKit/JLYSegmentControl.h>
#import <JLYKit/NSObject+DateString.h>

#define kScreenWidth   ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight  ([UIScreen mainScreen].bounds.size.height)
#define kDefaultWidth self.frame.size.width
#define kDefaultHeight self.frame.size.height
#define kDefaultColor [UIColor blueColor]

NS_ASSUME_NONNULL_BEGIN
@interface JLYDatePickerView ()

@property (nonatomic, strong) UIView *back_View;
@property (nonatomic, strong) UILabel *startTime_Label;
@property (nonatomic, strong) UILabel *endTime_Label;
@property (nonatomic, strong) UILabel *symbol_Label;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *pick_Btn;
@property (nonatomic, strong) JLYSegmentControl *segment;
@property (nonatomic, strong) UIView *select_View;
@property (nonatomic, strong) UIButton *select_btn;
@property (nonatomic, assign) NSInteger selectedIndex;

@end
NS_ASSUME_NONNULL_END
@implementation JLYDatePickerView
#pragma mark - LifeCycle
- (instancetype)init{
    if (self = [super init]) {
        _selectedIndex = 0;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.frame = CGRectMake(10.0f, kScreenHeight - 370.0f, kScreenWidth - 20.0f, 350.0f);
        self.layer.cornerRadius = 10.0f;
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        [window addSubview:self.back_View];
        [window addSubview:self];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [self addSubview:self.startTime_Label];
    [self addSubview:self.endTime_Label];
    [self addSubview:self.symbol_Label];
    [self addSubview:self.segment];
    [self addSubview:self.datePicker];
    [self.select_View addSubview:self.select_btn];
    [self addSubview:self.select_View];
    [self addSubview:self.pick_Btn];
}
#pragma mark - PublicMethod
- (void)show {
    //[self beginDateBtnClick:self.beginDateBtn];
    [UIView animateWithDuration:0.75f
                          delay:0.0f
         usingSpringWithDamping:0.7f
          initialSpringVelocity:0.8f
                        options:UIViewAnimationOptionTransitionCurlUp
                     animations:^{
                         self.back_View.hidden = NO;
        
                         CGRect newFrame = self.frame;
                         newFrame.origin.y = kScreenHeight - 370.0f;
                         self.frame = newFrame;
                     }
                     completion:nil];
}
#pragma mark - PrivateMethod
- (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)refreshSelectState{
   self.pick_Btn.enabled = (![self.startTime_Label.text isEqualToString:@"请选择"] && ![self.endTime_Label.text isEqualToString:@"请选择"]);
    if (self.pick_Btn.enabled) {
        NSString *beginDateStr = [self.startTime_Label.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSString *endDateStr = [self.endTime_Label.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        if (beginDateStr.integerValue > endDateStr.integerValue) {
            [self.pick_Btn setTitle:@"开始时间须小于结束时间" forState:UIControlStateDisabled];
            self.pick_Btn.enabled = NO;
        } else {
            [self.pick_Btn setTitle:@"开始查询" forState:UIControlStateNormal];
        }
    }

}
#pragma mark - EventResponse
- (void)hide {
    [UIView animateWithDuration:0.35f
                          delay:0.0f
         usingSpringWithDamping:0.7f
          initialSpringVelocity:0.5f
                        options:0.0f
                     animations:^{
                         self.back_View.hidden = YES;
                         CGRect newFrame = self.frame;
                         newFrame.origin.y = kScreenHeight;
                         self.frame = newFrame;
                     }
                     completion:nil];
}

- (void)selectTime:(id)sender{
    static NSDateFormatter* formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale currentLocale]];
    }
    [formatter setDateFormat:_dateFormat ? : @"YYYY-MM-dd"];
    if (self.selectedIndex) {
        self.endTime_Label.text = [formatter stringFromDate:self.datePicker.date];
    }else{
        self.selectedIndex = 1;
        self.startTime_Label.text = [formatter stringFromDate:self.datePicker.date];
        self.endTime_Label.text = [self monthEndDay:self.datePicker.date];
    }
    [self refreshSelectState];
}

- (void)dateSelectComplete:(id)sender{
    [self hide];
    if (self.SelectDateBlock) {
        self.SelectDateBlock(self.startTime_Label.text, self.endTime_Label.text);
    }
}

#pragma mark - SettersAndGetters
- (void)setThemeColor:(UIColor *)themeColor{
    self.segment.layer.borderColor = themeColor.CGColor;
    self.segment.titlesCustomColor = themeColor;
    self.segment.backgroundHighlightColor = themeColor;
    self.segment.titlesHighlightColor = [UIColor whiteColor];
    [self.select_btn setBackgroundColor:themeColor];
    [self.pick_Btn setBackgroundImage:[self createImageWithColor:themeColor] forState:UIControlStateNormal];
    [self layoutIfNeeded];
    [self refreshSelectState];
}

- (UIView *)back_View{
    if (!_back_View) {
        _back_View = ({
            UIView *view = [[UIView alloc] init];
            view.frame = CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight);
            view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
            view.hidden = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
            [view addGestureRecognizer:tap];
            view;
        });
    }
    return _back_View;
}

- (UILabel *)startTime_Label{
    if (!_startTime_Label) {
        _startTime_Label = ({
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0.0f, 10.0f, (kDefaultWidth - 10.0f) / 2, 30.0f);
            label.text = @"请选择";
            label.textColor = [UIColor darkGrayColor];
            label.font = [UIFont systemFontOfSize:16.0f];
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
    }
    return _startTime_Label;
}

- (UILabel *)endTime_Label{
    if (!_endTime_Label) {
        _endTime_Label = ({
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(kDefaultWidth / 2 + 5.0f, 10.0f, (kDefaultWidth - 10.0f) / 2, 30.0f);
            label.text = @"请选择";
            label.textColor = [UIColor darkGrayColor];
            label.font = [UIFont systemFontOfSize:16.0f];
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
    }
    return _endTime_Label;
}

- (UILabel *)symbol_Label{
    if (!_symbol_Label) {
        _symbol_Label = ({
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(kDefaultWidth / 2 - 5.0f, 10.0f, 10.0f, 30.0f);
            label.text = @"~";
            label.textColor = [UIColor darkGrayColor];
            label.font = [UIFont systemFontOfSize:16.0f];
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
    }
    return _symbol_Label;
}

- (JLYSegmentControl *)segment{
    if (!_segment) {
        _segment = ({
            JLYSegmentControl *v = [[JLYSegmentControl alloc] init];
            v.frame = CGRectMake(10.0f, 50.0f, kDefaultWidth - 20.0f, 44.0f);
            v.layer.cornerRadius = 22.0f;
            v.layer.borderWidth = 2.0f;
            v.backgroundColor = [UIColor whiteColor];
            v.titles = @[@"开始时间", @"结束时间"];
            v.duration = 0.3f;
            v.titlesCustomColor = [UIColor whiteColor];
            v.backgroundHighlightColor = [UIColor whiteColor];
            v.titlesHighlightColor = [UIColor colorWithRed:62.0f/255.0f green:181.0f/255.0f blue:169.0f/255.0f alpha:1.0f];
            __weak typeof(self) weakSelf = self;
            [v setButtonOnClickBlock:^(NSInteger tag, NSString *title) {
                weakSelf.selectedIndex = tag;
            }];
            v;
        });
    }
    return _segment;
}

- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.maximumDate = [NSDate date];
        CGRect newFrame = _datePicker.frame;
        newFrame.size.width = kDefaultWidth * 4 / 5;
        newFrame.origin.x = 20.0f;
        newFrame.origin.y = 100.0f;
        self.datePicker.frame = newFrame;
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    return _datePicker;
}

- (UIView *)select_View{
    if (!_select_View) {
        _select_View = ({
            UIView *view = [[UIView alloc] init];
            view.frame = CGRectMake(0.0f, _datePicker.center.y - 18.0f, kDefaultWidth, 35.0f);
            view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
            view.layer.cornerRadius = 20.0f;
            view;
        });
    }
    return _select_View;
}

- (UIButton *)select_btn{
    if (!_select_btn) {
        _select_btn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = kDefaultColor;
            btn.frame = CGRectMake(kDefaultWidth - 35.0f, 0.0f, 35.0f, 35.0f);
            btn.layer.cornerRadius = 17.5f;
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(btn.center.x, btn.center.y) radius:self.frame.size.width/2.0 startAngle:0 endAngle:M_PI*2 clockwise:YES];
            //对拐角和中点处理
            path.lineCapStyle  = kCGLineCapRound;
            path.lineJoinStyle = kCGLineCapRound;
            
            //对号第一部分直线的起始
            [path moveToPoint:CGPointMake(btn.frame.size.width/5, btn.frame.size.width/2)];
            CGPoint p1 = CGPointMake(btn.frame.size.width/5.0*2, btn.frame.size.width/4.0*3);
            [path addLineToPoint:p1];
            
            //对号第二部分起始
            CGPoint p2 = CGPointMake(btn.frame.size.width/8.0*7, btn.frame.size.width/3);
            [path addLineToPoint:p2];
            
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            //内部填充颜色
            layer.fillColor = [UIColor clearColor].CGColor;
            //线条颜色
            layer.strokeColor = [UIColor whiteColor].CGColor;
            //线条宽度
            layer.lineWidth = 2;
            layer.path = path.CGPath;
            //动画设置
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
            animation.fromValue = @0;
            animation.toValue = @1;
            animation.duration = 0.1;
            [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
            
            [btn.layer addSublayer:layer];
            [btn addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
    }
    return _select_btn;
}

- (UIButton *)pick_Btn{
    if (!_pick_Btn) {
        _pick_Btn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"请选择开始时间" forState:UIControlStateNormal];
            [btn setBackgroundImage:[self createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
            btn.frame = CGRectMake(0.0f, kDefaultHeight - 44.0f, kDefaultWidth, 44.0f);
            [btn addTarget:self action:@selector(dateSelectComplete:) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
    }
    return _pick_Btn;
}

@end
