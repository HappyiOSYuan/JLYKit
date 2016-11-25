//
//  JLYViewController.m
//  JLYKit
//
//  Created by HappyiOSYuan on 09/23/2016.
//  Copyright (c) 2016 HappyiOSYuan. All rights reserved.
//

#import "JLYViewController.h"
#import <JLYKit/JLYURLRouter.h>

@interface JLYViewController ()

@end

@implementation JLYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"JLYKit";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0.0f, 0.0f, 70.0f, 30.0f);
    btn.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = btn.titleLabel.textColor.CGColor;
    btn.layer.borderWidth = 2.0f;
    btn.layer.cornerRadius = 15.0f;
    [self.view addSubview:btn];
}

- (void)viewDidAppear:(BOOL)animated{
    @WeakObj(self);
    [self.eventHandler jly_handleDataWithIdentifer:nil
                                         andParams:nil
                                 CompletionHandler:^(id result, NSError *error){
                                     @StrongObj(self);
                                     NSLog(@"title--->%@" ,self.title);
                                 }];
    [self hideLoadingUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)push:(id)sender{
    [self.eventHandler jly_openVCWithIdentifer:nil andParam:nil];
}

@end
