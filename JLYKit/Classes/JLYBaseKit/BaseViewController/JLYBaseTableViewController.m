//
//  JLYBaseTableViewController.m
//  BaseViewController
//
//  Created by mac on 16/3/14.
//  Copyright © 2016年 ningyuan. All rights reserved.
//

#import "JLYBaseTableViewController.h"
#import "JLYBaseTableViewCell.h"
#import "UIScrollView+EmptyDataSet.h"

@interface JLYBaseTableViewController ()<JLYEmptyDataSetDelegate ,JLYEmptyDataSetSource ,UIScrollViewDelegate>

@end

@implementation JLYBaseTableViewController
@synthesize tableView = _tableView;
@synthesize dataArray = _dataArray;

//加载视图
- (void)loadView{
    [super loadView];
    //自定制视图
}

- (void)configSubviews{
    [super configSubviews];
}

- (void)configConstraints{
    
}
//加载视图完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加tableView
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view, typically from a nib.
    self.isOpenHeaderRefresh = NO;
    self.isOpenFooterRefresh = NO;
}
//视图将要出现
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.dataArray.count > 0) {
        [self.dataArray removeAllObjects];
    }
    if (self.sectionArray.count > 0) {
        [self.sectionArray removeAllObjects];
    }
    [self.tableView reloadData];
}
//视图已经出现
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showLoadingUIWith:self.tableView];
    [self headerRefresh];
}
//视图将要消失
- (void)viewWillDisappear:(BOOL)animated{
    if (self.dataArray.count > 0) {
        [self.dataArray removeAllObjects];
    }
    if (self.sectionArray.count > 0) {
        [self.sectionArray removeAllObjects];
    }
    [self.tableView reloadData];
}
//视图已经消失
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
//收到系统内存警告
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - SystemDelegate
#pragma mark - CustomDelegate
- (NSAttributedString *)ndb_titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"什么也没有";
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode  = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{
                                 NSFontAttributeName : font(20.0f),
                                 NSForegroundColorAttributeName : [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName : paragraphStyle
                                 };
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    return string;
}

- (NSAttributedString *)ndb_descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @" ";
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode  = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{
                                 NSFontAttributeName : font(20.0f),
                                 NSForegroundColorAttributeName : [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName : paragraphStyle
                                 };
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    return string;
}

- (NSAttributedString *)ndb_buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    return nil;
}

- (UIImage *)ndb_imageForEmptyDataSet:(UIScrollView *)scrollView{
    return nil;
}

- (UIColor *)ndb_backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    return backColor(nil);
}

- (UIView *)ndb_customViewForEmptyDataSet:(UIScrollView *)scrollView{
    return nil;
}
#pragma mark - EmptyData DataSource
- (BOOL)ndb_emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return YES;
}

- (BOOL)ndb_emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    return YES;
}

- (BOOL)ndb_emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return NO;
}

- (void)ndb_emptyDataSetDidTapView:(UIScrollView *)scrollView{
    [self headerRefresh];
}
#pragma mark - EventResponce
- (void)selectCell:(id)sender{
    
}

- (void)refreshData{
    [self headerRefresh];
}
#pragma mark - PrivateMethod
- (void)headerRefresh{
    [self.tableView reloadEmptyDataSet];
    if (self.dataArray.count > 0) {
        [self.dataArray removeAllObjects];
    }
    if (self.sectionArray.count > 0) {
        [self.sectionArray removeAllObjects];
    }
    [self.tableView reloadData];
}

- (void)footerRefresh{
    
}

- (void)hideLoadingUI{
    [self hideLoadingUIWith:self.tableView];
}

- (void)goNetNotUse:(UIButton *)sender{
    [super goNetNotUse:sender];
    
}
#pragma mark - SettersAndGetters
- (NSMutableArray *)dataArray{
    if (!_dataArray ) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (NSMutableArray *)sectionArray{
    if (!_sectionArray ) {
        _sectionArray = [[NSMutableArray alloc]init];
    }
    return _sectionArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, screenWidth, 0.1f)];
        _tableView.estimatedRowHeight = 0.0f;
        _tableView.estimatedSectionHeaderHeight = 0.0f;
        _tableView.estimatedSectionFooterHeight = 0.0f;
        _tableView.backgroundColor = backColor(nil);
    }
    return _tableView;
}

- (void)setIsOpenHeaderRefresh:(BOOL)isOpenHeaderRefresh{
    _isOpenHeaderRefresh =  isOpenHeaderRefresh;
    if (_isOpenHeaderRefresh) {
        @weakify(self);
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self headerRefresh];
        }];
    }else{
        self.tableView.mj_header = nil;
    }
}

- (void)setIsOpenFooterRefresh:(BOOL)isOpenFooterRefresh{
    _isOpenFooterRefresh =  isOpenFooterRefresh;
    if (_isOpenFooterRefresh) {
        @weakify(self);
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            @strongify(self);
            [self footerRefresh];
        }];
    }else{
        self.tableView.mj_footer = nil;
    }
}

@end
