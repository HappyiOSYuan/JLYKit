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
    @WeakObj(self);
    return ^JLYTableViewSectionMaker *(Class cell) {
        @StrongObj(self);
        self.section.cellClazz = cell;
        if (!self.section.identifier) {
            self.section.identifier = [self getSectionIdentifer];
        }
        return self;
    };
}

- (JLYTableViewSectionMaker * (^)(NSArray *))dataList {
    @WeakObj(self);
    return ^JLYTableViewSectionMaker *(NSArray * data) {
        @StrongObj(self);
        self.section.dataList = data;
        return self;
    };
}

- (JLYTableViewSectionMaker * (^)(CellConfigBlock))cellConfig {
    @WeakObj(self);
    return ^JLYTableViewSectionMaker *(CellConfigBlock cellConfigBlock) {
        @StrongObj(self);
        self.section.cellConfig = cellConfigBlock;
        return self;
    };
}

- (JLYTableViewSectionMaker * (^)(CGFloat))height {
    @WeakObj(self);
    return ^JLYTableViewSectionMaker *(CGFloat height) {
        @StrongObj(self);
        self.section.staticHeight = height;
        return self;
    };
}

- (JLYTableViewSectionMaker * (^)())autoHeight {
    @WeakObj(self);
    return ^JLYTableViewSectionMaker * {
        @StrongObj(self);
        self.section.isAutoHeight = YES;
        return self;
    };
}

- (JLYTableViewSectionMaker * (^)(CellEventBlock))cellEvent {
    @WeakObj(self);
    return ^JLYTableViewSectionMaker *(CellEventBlock cellEventBlock) {
        @StrongObj(self);
        self.section.cellEvent = cellEventBlock;
        return self;
    };
}

- (JLYTableViewSectionMaker * (^)(NSString *))headerTitle {
    @WeakObj(self);
    return ^JLYTableViewSectionMaker *(NSString * title) {
        @StrongObj(self);
        self.section.headerTitle = title;
        return self;
    };
}

- (JLYTableViewSectionMaker * (^)(NSString *))footerTitle {
    @WeakObj(self);
    return ^JLYTableViewSectionMaker *(NSString * title) {
        @StrongObj(self);
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

- (JLYTableViewSectionMaker * (^)(__kindof UITableViewHeaderFooterView * (^)()))headerView {
    @WeakObj(self);
    return ^JLYTableViewSectionMaker *(__kindof UITableViewHeaderFooterView * (^view)()) {
        @StrongObj(self);
        self.section.headerView = view();
        return self;
    };
}

- (JLYTableViewSectionMaker * (^)(__kindof UITableViewHeaderFooterView * (^)()))footerView {
    @WeakObj(self);
    return ^JLYTableViewSectionMaker *(__kindof UITableViewHeaderFooterView * (^view)()) {
        @StrongObj(self);
        self.section.footerView = view();
        return self;
    };
}

@end
