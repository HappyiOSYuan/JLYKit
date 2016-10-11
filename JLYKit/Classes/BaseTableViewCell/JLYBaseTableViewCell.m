//
//  JLYBaseTableViewCell.m
//  JLYBaseViewController
//
//  Created by TJBT on 16/3/15.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYBaseTableViewCell.h"
#import "UIView+Additions.h"

@implementation JLYBaseTableViewCell
@synthesize tableView = _tableView;
@synthesize row = _row;
@synthesize section = _section;
@synthesize indexPath = _indexPath;

- (void)configSubviews{
    
}

- (void)configConstraints{
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configSubviews];
        [self configConstraints];
        _tableView = [self superTable];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)handlerButtonAction:(BaseTableViewCellBlock)block{
    NSAssert(block != nil, @"block should not be nil");
    self.cellBlock = block;
    if (_cellBlock) {
        _cellBlock(_model);
        _cellBlock = nil;
    }
}

- (void)setModel:(id)model{
    NSAssert(model != nil, @"model should not be nil");
    if (_model != model) {
        _model = model;
    }
    _indexPath = [_tableView indexPathForCell:self];
    _row = _indexPath.row;
    _section = _indexPath.section;
}

- (UITableView *)superTable{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UITableView class]]) {
            return (UITableView *)nextResponder;
        }
    }
}

@end
