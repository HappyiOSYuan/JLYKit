//
//  JLYPushViewController.m
//  JLYKit
//
//  Created by 袁宁 on 2016/11/24.
//  Copyright © 2016年 HappyiOSYuan. All rights reserved.
//

#import "JLYPushViewController.h"
#import <JLYKit/JLYSegmentControl.h>
#import <JLYKit/JLYDatePickerView.h>

@interface JLYPushViewController ()

@end

@implementation JLYPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"pushvc";
    JLYSegmentControl *v = [[JLYSegmentControl alloc] init];
    v.frame = CGRectMake(30.0f, 90.0f, screenWidth - 60.0f, 44.0f);
    v.layer.cornerRadius = 22.0f;
    v.backgroundColor = [UIColor colorWithRed:74.0f/255.0f green:74.0f/255.0f blue:74.0f/255.0f alpha:1.0f];
    v.titles = @[@"本月", @"上月", @"年度", @"自定义"];
    v.duration = 0.3f;
    v.titlesCustomColor = [UIColor whiteColor];
    v.backgroundHighlightColor = [UIColor whiteColor];
    v.titlesHighlightColor = [UIColor colorWithRed:62.0f/255.0f green:181.0f/255.0f blue:169.0f/255.0f alpha:1.0f];
    //__weak typeof(self) weakSelf = self;
    [v setButtonOnClickBlock:^(NSInteger tag, NSString *title) {
        JLYDatePickerView *picker = [[JLYDatePickerView alloc] init];
        [picker setThemeColor:[UIColor colorWithRed:62.0f/255.0f green:181.0f/255.0f blue:169.0f/255.0f alpha:1.0f]];
        picker.SelectDateBlock = ^(NSString *startDateStr, NSString *endDateStr){
            NSLog(@"start--->%@, end--->%@", startDateStr, endDateStr);
        };
        [picker show];
    }];
    
    [self.view addSubview:v];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self hideLoadingUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
