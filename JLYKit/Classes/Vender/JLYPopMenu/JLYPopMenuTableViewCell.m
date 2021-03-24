//
//  JLYPopMenuTableViewCell.m
//  GenericFramework
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYPopMenuTableViewCell.h"
#import "JLYPopMenuModel.h"
#import "SDAutoLayout.h"

@implementation JLYPopMenuTableViewCell

#pragma mark - LifeCycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
        [self.contentView addSubview:self.menu_ImageView];
        [self.contentView addSubview:self.menu_Label];
        
        self.menu_ImageView.sd_layout
        .leftSpaceToView(self.contentView ,10.0f)
        .centerYEqualToView(self.contentView)
        .heightIs(12.0f)
        .widthIs(12.0f);
        
        self.menu_Label.sd_layout
        .leftSpaceToView(self.menu_ImageView ,10.0f)
        .topSpaceToView(self.contentView ,0.0f)
        .rightSpaceToView(self.contentView ,10.0f)
        .bottomSpaceToView(self.contentView ,0.0f);
    }
    return self;
}
#pragma mark - PrivateMethod
- (void)setUpUI{
    self.backgroundColor = [UIColor clearColor];
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.textLabel.textColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
}
#pragma mark - SettersAndGetters
- (void)setModel:(id)model{
    if (model) {
        if ([model isKindOfClass:[JLYPopMenuModel class]]) {
            JLYPopMenuModel *menuModel = model;
            self.menu_ImageView.image = [UIImage imageNamed:menuModel.imageName];
            self.menu_Label.text = menuModel.itemName;
        }
    }
    
}

- (UIImageView *)menu_ImageView{
    if (!_menu_ImageView) {
        _menu_ImageView = [[UIImageView alloc] init];
    }
    return _menu_ImageView;
}

- (UILabel *)menu_Label{
    if (!_menu_Label) {
        _menu_Label = ({
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:12.0f];
            label;
        });
    }
    return _menu_Label;
}

@end
