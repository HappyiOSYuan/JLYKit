//
//  JLYPopMenuView.m
//  GenericFramework
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYPopMenuView.h"
#import "JLYPopMenuModel.h"
#import "JLYPopMenuTableViewCell.h"

@interface JLYPopMenuView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * backView;
@property (nonatomic, assign) CGRect rect;
@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, strong) UIViewController * target;

@end

@implementation JLYPopMenuView
#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.alpha = 0;
    }
    return self;
}

+ (instancetype)createMenuWithFrame:(CGRect)frame
                             target:(UIViewController *)target
                          dataArray:(NSArray *)dataArray
                    itemsClickBlock:(void (^)(NSString *, NSInteger))itemsClickBlock
                        backViewTap:(void (^)())backViewTapBlock{
    
    JLYPopMenuView *menuView = [[JLYPopMenuView alloc] initWithFrame:frame];
    menuView.rect = frame;
    menuView.target = target;
    menuView.dataArray = dataArray;
    menuView.itemsClickBlock = itemsClickBlock;
    menuView.backViewTapBlock = backViewTapBlock;
    [menuView setUpUIWithFrame:frame];
    menuView.layer.anchorPoint = CGPointMake(1, 0);
    menuView.layer.position = CGPointMake(frame.origin.x + frame.size.width, frame.origin.y);
    menuView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [target.view addSubview:menuView];
    return menuView;
}
#pragma mark - SystemDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JLYPopMenuTableViewCell *cell = (JLYPopMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JLYPopMenuTableViewCell class]) forIndexPath:indexPath];
    [cell setModel:self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JLYPopMenuModel *model = self.dataArray[indexPath.row];
    if (self.itemsClickBlock) {
        [self showMenuWithAnimation:NO];
        self.itemsClickBlock(model.itemName,indexPath.row);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - EventResponse
- (void)tap:(UITapGestureRecognizer *)sender{
    [self showMenuWithAnimation:NO];
    if (self.backViewTapBlock) {
        self.backViewTapBlock();
    }
}
#pragma mark - PublicMethod
- (void)showMenuWithAnimation:(BOOL)isShow{
    [UIView animateWithDuration:0.25
                     animations:^{
                         if (isShow) {
                             self.alpha = 1;
                             self.backView.alpha = 0.1;
                             self.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         }else{
                             self.alpha = 0;
                             self.backView.alpha = 0;
                             self.transform = CGAffineTransformMakeScale(0.01, 0.01);
                         }
                     }
                     completion:^(BOOL finished) {
                     
                     }];
}

- (void)popMenu{
    [self showMenuWithAnimation:!self.alpha];
}
#pragma mark - PrivateMethod
- (void)setUpUIWithFrame:(CGRect)frame{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.image = [UIImage imageNamed:@"pop_black_backGround"];
    [self addSubview:imageView];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 12, frame.size.width, frame.size.height - 12)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 40;
    [self.tableView registerClass:[JLYPopMenuTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JLYPopMenuTableViewCell class])];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                (self.target.navigationController.navigationBar.frame.origin.y + self.target.navigationController.navigationBar.frame.size.height),
                                                                self.target.view.bounds.size.width,
                                                                self.target.view.bounds.size.height
                                                                )];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.0;
    backView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [backView addGestureRecognizer:tap];
    self.backView = backView;
    [self.target.view addSubview:backView];
    [self addSubview:self.tableView];
}
#pragma mark - SettersAndGetters
- (void)setDataArray:(NSArray *)dataArray{
    
    NSMutableArray *tempMutableArr = [NSMutableArray array];
    [dataArray enumerateObjectsUsingBlock:^(NSDictionary *dict ,NSUInteger idx ,BOOL *stop){
        JLYPopMenuModel *model = [JLYPopMenuModel MenuModelWithDict:dict];
        [tempMutableArr addObject:model];
    }];
    _dataArray = [NSArray arrayWithArray:tempMutableArr];
}


@end
