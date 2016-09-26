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

- (JLYTableViewDataSourceMaker * (^)(UIView * (^)()))headerView {
    @WeakObj(self);
    return ^JLYTableViewDataSourceMaker *(UIView * (^view)()) {
        @StrongObj(self);
        UIView * headerView =  view();
        [self.tableView.tableHeaderView layoutIfNeeded];
        self.tableView.tableHeaderView = headerView;
        return self;
    };
}

- (JLYTableViewDataSourceMaker * (^)(UIView * (^)()))footerView {
    @WeakObj(self);
    return ^JLYTableViewDataSourceMaker *(UIView * (^view)()) {
        @StrongObj(self);
        UIView * footerView = view();
        [self.tableView.tableFooterView layoutIfNeeded];
        self.tableView.tableFooterView = footerView;
        return self;
    };
}

- (JLYTableViewDataSourceMaker * (^)(CGFloat))height {
    @WeakObj(self);
    return ^JLYTableViewDataSourceMaker *(CGFloat height) {
        @StrongObj(self);
        self.tableView.rowHeight = height;
        return self;
    };
}

- (void)commitEditing:(void (^)(UITableView *tableView,UITableViewCellEditingStyle *editingStyle, NSIndexPath *indexPath))block {
    self.commitEditingBlock = block;
}

- (void)scrollViewDidScroll:(void (^)(UIScrollView * scrollView))block {
    self.scrollViewDidScrollBlock = block;
}


- (void)makeSection:(void (^)(JLYTableViewSectionMaker * section))block {
    JLYTableViewSectionMaker * sectionMaker = [JLYTableViewSectionMaker new];
    block(sectionMaker);
    if (sectionMaker.section.cellClazz) {
        [self.tableView registerClass:sectionMaker.section.cellClazz forCellReuseIdentifier:sectionMaker.section.identifier];
    }
    [self.sections addObject:sectionMaker.section];
}

- (NSMutableArray *)sections {
    if (! _sections) {
        _sections = [NSMutableArray new];
    }
    return _sections;
}

@end