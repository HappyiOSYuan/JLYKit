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
//    JLYSegmentControl *v =
//    JLYSegmentControlInit
//    .viewFrame(30.0f, 90.0f, screenWidth - 60.0f, 44.0f);
//    v.frame = CGRectMake(30.0f, 90.0f, screenWidth - 60.0f, 44.0f);
//    v.layer.cornerRadius = 22.0f;
//    v.backgroundColor = [UIColor colorWithRed:74.0f/255.0f green:74.0f/255.0f blue:74.0f/255.0f alpha:1.0f];
//
//    v
//    .SegmentTitles(@[@"本月", @"上月", @"年度", @"自定义"])
//    .SegmentTitlesCustomColor([UIColor whiteColor])
//    .SegmentTitlesHighlightColor([UIColor colorWithRed:62.0f/255.0f green:181.0f/255.0f blue:169.0f/255.0f alpha:1.0f])
//    .SegmentBackgroundHighlightColor([UIColor whiteColor])
//    .SegmentBorderHighlightColor([UIColor colorWithRed:62.0f/255.0f green:181.0f/255.0f blue:169.0f/255.0f alpha:1.0f])
//    .SegmentClickBlock(^(NSInteger tag, NSString *title){
//        if (0 == tag) {
//            JLYDatePickerView *picker = JLYDatePickerInit;
//            picker
//            .DatePickerTheme([UIColor colorWithRed:62.0f/255.0f green:181.0f/255.0f blue:169.0f/255.0f alpha:1.0f])
//            .DatePickerSelectedBlock(^(NSString *startDateStr, NSString *endDateStr){
//                NSLog(@"start--->%@, end--->%@", startDateStr, endDateStr);
//            });
//            [picker show];
//        }
//    });
//    
//    [self.view addSubview:v];
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
