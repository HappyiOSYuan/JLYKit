//
//  UITableView+JLYTableViewDataSource.m
//  Pods
//
//  Created by mac on 16/9/20.
//
//

#import "UITableView+JLYTableViewDataSource.h"
#import <objc/runtime.h>
#import "JLYBaseTableViewDataSource.h"
#import "JLYTableViewDataSourceMaker.h"
#import "JLYTableViewSectionMaker.h"
#import "JLYDataSourceSection.h"
#import "JLYBaseTableViewCell.h"

static NSString * getIdentifier (){
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString * retStr = (__bridge NSString *) uuidStrRef;
    CFRelease(uuidStrRef);
    return retStr;
}

@implementation UITableView (JLYTableViewDataSource)

- (JLYBaseTableViewDataSource *)jlyTableViewDataSource {
    return objc_getAssociatedObject(self,_cmd);
}

- (void)setJlyTableViewDataSource:(JLYBaseTableViewDataSource *)jlyTableViewDataSource {
    objc_setAssociatedObject(self,@selector(jlyTableViewDataSource),jlyTableViewDataSource,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)jly_makeDataSource:(void(^)(JLYTableViewDataSourceMaker * make))maker {
    JLYTableViewDataSourceMaker * make = [[JLYTableViewDataSourceMaker alloc] initWithTableView:self];
    maker(make);
    Class DataSourceClass = [JLYBaseTableViewDataSource class];
    NSMutableDictionary<NSString *, id> *delegates = [NSMutableDictionary dictionary];
    if(make.commitEditingBlock||make.scrollViewDidScrollBlock) {
        DataSourceClass = objc_allocateClassPair([JLYBaseTableViewDataSource class], [getIdentifier() UTF8String],0);
        if(make.commitEditingBlock) {
            class_addMethod(DataSourceClass,NSSelectorFromString(@"tableView:commitEditingStyle:forRowAtIndexPath:"),(IMP)commitEditing,"v@:@@@");
            delegates[@"tableView:commitEditingStyle:forRowAtIndexPath:"] = make.commitEditingBlock;
        }
        if(make.scrollViewDidScrollBlock) {
            class_addMethod(DataSourceClass,NSSelectorFromString(@"scrollViewDidScroll:"),(IMP)scrollViewDidScroll,"v@:@");
            delegates[@"scrollViewDidScroll:"] = make.scrollViewDidScrollBlock;
        }
    }
    
    if(!self.tableFooterView) {
        self.tableFooterView = [UIView new];
    }
    
    id<JLYBaseTableViewDataSourceProtocol> ds = (id<JLYBaseTableViewDataSourceProtocol>) [DataSourceClass new];
    ds.sections = make.sections;
    ds.delegates = delegates;
    self.jlyTableViewDataSource = ds;
    self.dataSource = ds;
    self.delegate = ds;
}

- (void)jly_makeSectionWithData:(NSArray *)dataList {
    
    NSMutableDictionary<NSString *, id> *delegates = [NSMutableDictionary dictionary];
    JLYTableViewSectionMaker * make = [JLYTableViewSectionMaker new];
    make.dataList(dataList);
    make.cellClazz([JLYBaseTableViewCell class]);
    [self registerClass:make.section.cellClazz forCellReuseIdentifier:make.section.identifier];
    id<JLYBaseTableViewDataSourceProtocol> ds = [JLYBaseTableViewDataSource new];
    
    if(!self.tableFooterView) {
        self.tableFooterView = [UIView new];
    }
    
    ds.sections = [@[make.section] mutableCopy];
    ds.delegates = delegates;
    self.jlyTableViewDataSource = ds;
    self.dataSource = ds;
    self.delegate = ds;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (void)jly_makeSectionWithData:(NSArray *)dataList andCellClass:(Class)cellClass {
    [self jly_makeDataSource:^(JLYTableViewDataSourceMaker * make) {
        [make makeSection:^(JLYTableViewSectionMaker * section) {
            section.dataList(dataList);
            section.cellClazz(cellClass);
            section.cellConfig(^(id cell, id model, NSIndexPath *indexPath) {
                if([cell respondsToSelector:NSSelectorFromString(@"setModel:")]) {
                    [cell performSelector:NSSelectorFromString(@"setModel:") withObject:model];
                }
            });
            section.autoHeight();
        }];
    }];
}
#pragma clang diagnostic pop

@end

static void commitEditing(id self, SEL cmd, UITableView *tableView,UITableViewCellEditingStyle editingStyle,NSIndexPath * indexPath){
    JLYBaseTableViewDataSource * ds = self;
    void(^block)(UITableView * ,UITableViewCellEditingStyle ,NSIndexPath *) = ds.delegates[NSStringFromSelector(cmd)];
    if(block) {
        block(tableView,editingStyle,indexPath);
    }
}

static void scrollViewDidScroll(id self, SEL cmd, UIScrollView * scrollView) {
    JLYBaseTableViewDataSource * ds = self;
    void(^block)(UIScrollView *) = ds.delegates[NSStringFromSelector(cmd)];
    if(block) {
        block(scrollView);
    }
};
