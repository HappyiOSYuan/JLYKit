//
//  JLYTableViewDataSourceMaker.m
//  Pods
//
//  Created by mac on 16/9/20.
//
//

#import "JLYTableViewDataSourceMaker.h"
#import "JLYTableViewSectionMaker.h"
#import "JLYDataSourceSection.h"
#import "viewControllerConfig.h"

@implementation JLYTableViewDataSourceMaker

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        self.tableView = tableView;
    }
    return self;
}

- (JLYTableViewDataSourceMaker * (^)(UIView * (^)(void)))headerView {
    @weakify(self);
    return ^JLYTableViewDataSourceMaker *(UIView * (^view)(void)) {
        @strongify(self);
        UIView * headerView =  view();
        [self.tableView.tableHeaderView layoutIfNeeded];
        self.tableView.tableHeaderView = headerView;
        return self;
    };
}

- (JLYTableViewDataSourceMaker * (^)(UIView * (^)(void)))footerView {
    @weakify(self);
    return ^JLYTableViewDataSourceMaker *(UIView * (^view)(void)) {
        @strongify(self);
        UIView * footerView = view();
        [self.tableView.tableFooterView layoutIfNeeded];
        self.tableView.tableFooterView = footerView;
        return self;
    };
}

- (JLYTableViewDataSourceMaker * (^)(CGFloat))height {
    @weakify(self);
    return ^JLYTableViewDataSourceMaker *(CGFloat height) {
        @strongify(self);
        self.tableView.rowHeight = height;
        return self;
    };
}

- (void)commitEditing:(void(^)(__kindof UITableView *tableView, UITableViewCellEditingStyle *editingStyle, NSIndexPath *indexPath))block {
    self.commitEditingBlock = block;
}

- (void)scrollViewDidScroll:(void (^)(UIScrollView * scrollView))block {
    self.scrollViewDidScrollBlock = block;
}


- (void)makeSection:(void (^)(JLYTableViewSectionMaker * section))block {
    JLYTableViewSectionMaker * sectionMaker = [JLYTableViewSectionMaker new];
    block(sectionMaker);
    if (sectionMaker.section.cellRegisterType == JLYCellRegisterTypeClass) {
        [self.tableView registerClass:sectionMaker.section.cellClazz forCellReuseIdentifier:sectionMaker.section.identifier];
    }else{
        UINib *nib = [UINib nibWithNibName:NSStringFromClass(sectionMaker.section.cellClazz) bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:sectionMaker.section.identifier];
    }
    [self.sections addObject:sectionMaker.section];
}

- (NSMutableArray<JLYDataSourceSection *> *)sections {
    if (! _sections) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

@end
