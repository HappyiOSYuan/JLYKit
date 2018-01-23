//
//  JLYTableViewSectionMaker.m
//  Pods
//
//  Created by mac on 16/9/20.
//
//

#import "JLYTableViewSectionMaker.h"
#import "JLYDataSourceSection.h"
#import "viewControllerConfig.h"

@implementation JLYTableViewSectionMaker

- (JLYTableViewSectionMaker * (^)(Class))cellClazz {
    @weakify(self);
    return ^JLYTableViewSectionMaker *(Class cell) {
        @strongify(self);
        self.section.cellClazz = cell;
        if (!self.section.identifier) {
            self.section.identifier = [self getSectionIdentifer];
        }
        return self;
    };
}

- (JLYTableViewSectionMaker * (^)(NSArray *))dataList {
    @weakify(self);
    return ^JLYTableViewSectionMaker *(NSArray * data) {
        @strongify(self);
        self.section.dataList = data;
        return self;
    };
}

- (JLYTableViewSectionMaker * (^)(NSArray *))actions {
    return ^JLYTableViewSectionMaker *(NSArray * actions) {
        self.section.actions = actions;
        return self;
    };
}

- (JLYTableViewSectionMaker * (^)(CellConfigBlock))cellConfig {
    @weakify(self);
    return ^JLYTableViewSectionMaker *(CellConfigBlock cellConfigBlock) {
        @strongify(self);
        self.section.cellConfig = cellConfigBlock;
        return self;
    };
}

- (JLYTableViewSectionMaker * (^)(CGFloat))height {
    @weakify(self);
    return ^JLYTableViewSectionMaker *(CGFloat height) {
        @strongify(self);
        self.section.staticHeight = height;
        return self;
    };
}

- (JLYTableViewSectionMaker * (^)(void))autoHeight {
    @weakify(self);
    return ^JLYTableViewSectionMaker * {
        @strongify(self);
        self.section.isAutoHeight = YES;
        return self;
    };
}

- (JLYTableViewSectionMaker * (^)(CellEventBlock))cellEvent {
    @weakify(self);
    return ^JLYTableViewSectionMaker *(CellEventBlock cellEventBlock) {
        @strongify(self);
        self.section.cellEvent = cellEventBlock;
        return self;
    };
}

- (JLYTableViewSectionMaker * (^)(NSString *))headerTitle {
    @weakify(self);
    return ^JLYTableViewSectionMaker *(NSString * title) {
        @strongify(self);
        self.section.headerTitle = title;
        return self;
    };
}

- (JLYTableViewSectionMaker * (^)(NSString *))footerTitle {
    @weakify(self);
    return ^JLYTableViewSectionMaker *(NSString * title) {
        @strongify(self);
        self.section.footerTitle = title;
        return self;
    };
}

- (JLYDataSourceSection *)section {
    if (! _section) {
        _section = [JLYDataSourceSection new];
    }
    return _section;
}

- (NSString *)getSectionIdentifer {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString * retStr = (__bridge NSString *) uuidStrRef;
    CFRelease(uuidStrRef);
    return retStr;
}

- (JLYTableViewSectionMaker * (^)(__kindof UITableViewHeaderFooterView * (^)(void)))headerView {
    @weakify(self);
    return ^JLYTableViewSectionMaker *(__kindof UITableViewHeaderFooterView * (^view)(void)) {
        @strongify(self);
        self.section.headerView = view();
        return self;
    };
}

- (JLYTableViewSectionMaker * (^)(__kindof UITableViewHeaderFooterView * (^)(void)))footerView {
    @weakify(self);
    return ^JLYTableViewSectionMaker *(__kindof UITableViewHeaderFooterView * (^view)(void)) {
        @strongify(self);
        self.section.footerView = view();
        return self;
    };
}

@end
