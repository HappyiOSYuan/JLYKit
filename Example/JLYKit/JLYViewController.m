//
//  JLYViewController.m
//  JLYKit
//
//  Created by HappyiOSYuan on 09/23/2016.
//  Copyright (c) 2016 HappyiOSYuan. All rights reserved.
//

#import "JLYViewController.h"
#import <JLYKit/JLYURLRouter.h>
#import <JLYKit/JLYMaterialTextFeild.h>
#import <JLYKit/NSString+JLYRegExKit.h>
#import <JLYKit/UIControl+JLYFixMultiClick.h>

@interface JLYViewController ()

@property (nonatomic, strong) JLYMaterialTextFeild *test_TextFeild;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation JLYViewController
#pragma mark - LifeCycle
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"JLYKit";
    [self setIsOpenNetListen:NO];
    self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btn.frame = CGRectMake(0.0f, self.viewToTop, 70.0f, 30.0f);
//    self.btn.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    [self.btn setTitle:@"push" forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    self.btn.layer.borderColor = self.btn.titleLabel.textColor.CGColor;
    self.btn.layer.borderWidth = 2.0f;
    self.btn.layer.cornerRadius = 15.0f;
    [self.view addSubview:self.btn];
    [self.view addSubview:self.test_TextFeild];
    NSLog(@"%f", self.viewToTop);
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"self.viewToTop--->%f", self.viewToTop);
    //self.btn.frame = CGRectMake(0.0f, self.viewToTop, 70.0f, 30.0f);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    @weakify(self);
    [self.eventHandler jly_handleDataWithIdentifer:nil
                                         andParams:nil
                                 CompletionHandler:^(id result, NSError *error){
                                     @strongify(self);
                                     NSLog(@"title--->%@" ,self.title);
                                 }];
    [self hideLoadingUI];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - EventResponse
- (void)push:(id)sender{
    [self.eventHandler jly_openVCWithIdentifer:nil andParam:nil];
}
#pragma mark - PrivateMethod
- (void)validatePhone{
    if ([self.test_TextFeild.text length] > 0) {
        if ([self.test_TextFeild.text regExPhone]) {
            [self.test_TextFeild setErrorMessage:NULL];
        }else{
            [self.test_TextFeild setErrorMessage:@"手机号不合法"];
        }
    }else{
        [self.test_TextFeild setErrorMessage:@"请输入手机号"];
    }
}

- (void)textChange:(JLYMaterialTextFeild *)textFeild{
    NSLog(@"text--->%@", textFeild.text);
    [self validatePhone];
}
#pragma mark - SettersAndGetters
- (JLYMaterialTextFeild *)test_TextFeild{
    if (!_test_TextFeild) {
        _test_TextFeild = ({
            JLYMaterialTextFeild *textFeild = [[JLYMaterialTextFeild alloc] init];
            textFeild.frame = CGRectMake(30.0f, 300.0f, screenWidth - 60.0f, 50.0f);
            textFeild.tintColor = [UIColor blueColor];
            textFeild.underlineNormalColor = [UIColor blueColor];
            [textFeild setPlaceholder:@"请输入密码" floatingTitle:@"密码"];
            textFeild.jly_acceptEventTime = 0.1f;
            [textFeild addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
            textFeild;
        });
    }
    return _test_TextFeild;
}

@end
