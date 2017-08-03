//
//  JLYBaseTableViewDataSource.m
//  Pods
//
//  Created by mac on 16/9/20.
//
//

#import "JLYBaseTableViewDataSource.h"
#import <objc/runtime.h>
#import "JLYDataSourceSection.h"
#import "viewControllerConfig.h"

@implementation JLYBaseTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell = [tableView dequeueReusableCellWithIdentifier:self.sections[indexPath.section].identifier
                                              forIndexPath:indexPath];
    CellConfigBlock configBlock = self.sections[indexPath.section].cellConfig;
    if (!configBlock) {
        NSAssert(configBlock != nil, @"Warning : adapter block for section %ld is null. please use dataSourceMake.adapter(^block) set it", indexPath.section);
        return cell;
    }
    id data = self.sections[indexPath.section].dataList[indexPath.row];
    configBlock(cell,data,indexPath);
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section].headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return self.sections[section].footerTitle;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.sections[section].headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.sections[section].footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(self.sections[section].headerView) {
        return self.sections[section].headerView.frame.size.height;
    } else if(self.sections[section].headerTitle) {
        return 40.0f;
    } else {
        return 0.0f;
    };
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(self.sections[(NSUInteger) section].footerView) {
        return self.sections[section].footerView.frame.size.height;
    } else if(self.sections[section].footerTitle) {
        return 40.0f;
    } else {
        return 0.0f;
    };
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    id data = self.sections[indexPath.section].dataList[indexPath.row];
    if(self.sections[indexPath.section].isAutoHeight) {
        return [tableView cellHeightForIndexPath:indexPath
                                           model:data
                                         keyPath:@"model"
                                       cellClass:self.sections[indexPath.section].cellClazz
                                contentViewWidth:screenWidth];
    } else if(0.0f < self.sections[indexPath.section].staticHeight){
        return self.sections[indexPath.section].staticHeight;
    } else {
        return tableView.rowHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellEventBlock eventBlock = (CellEventBlock) self.sections[indexPath.section].cellEvent;
    
    if(!eventBlock) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return ;
    }
    
    id data = self.sections[indexPath.section].dataList[indexPath.row];
    eventBlock(indexPath, data);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (__kindof UITableViewCell *)cellForReuseIdentifier:(NSString *)identifier withTableView:(UITableView*)tableView{
    NSAssert(identifier.length > 0, @"Expect a valid identifier - %@", identifier);
    
    NSMutableDictionary<NSString *, UITableViewCell *> *templateCellsByIdentifiers = objc_getAssociatedObject(self, _cmd);
    if (!templateCellsByIdentifiers) {
        templateCellsByIdentifiers = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, templateCellsByIdentifiers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    UITableViewCell *templateCell = templateCellsByIdentifiers[identifier];
    
    if (!templateCell) {
        templateCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        NSAssert(templateCell != nil, @"Cell must be registered to table view for identifier - %@", identifier);
        templateCell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        templateCellsByIdentifiers[identifier] = templateCell;
    }
    
    return templateCell;
}

- (NSMutableArray<JLYDataSourceSection *> *)sections {
    return objc_getAssociatedObject(self,_cmd);
}

- (void)setSections:(NSMutableArray<JLYDataSourceSection *> *)sections {
    objc_setAssociatedObject(self,@selector(sections),sections,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary * )delegates {
    return objc_getAssociatedObject(self,_cmd);
}

- (void)setDelegates:(NSMutableDictionary *)delegates {
    objc_setAssociatedObject(self,@selector(delegates),delegates,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
