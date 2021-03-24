//
//  JLYForm.m
//  GenericFramework
//
//  Created by mac on 16/7/22.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYForm.h"

@implementation JLYForm
@synthesize numRows = _numRows;
@synthesize columnsWidths = _columnsWidths;
@synthesize dy = _dy;

- (id)initWithFrame:(CGRect)frame andColumnsWidths:(__kindof NSArray<NSNumber *> *)columns{
    self = [super initWithFrame:frame];
    if (self) {
        _numRows = 0;
        _columnsWidths = columns;
        _dy = 0;
        _numRows = 0;
    }
    return self;
}

- (void)reloadData{
    _numRows = 0;
    _dy = 0;
    _numRows = 0;
    [self.subviews enumerateObjectsUsingBlock:^(UILabel *label ,NSUInteger idx ,BOOL *stop){
        if ([label isKindOfClass:[UILabel class]]) {
            [label removeFromSuperview];
        }
    }];
}

- (void)addRecord:(__kindof NSArray<NSString *>*)record{
    __block uint rowHeight = 50;
    __block uint dx = 0;
    
    NSMutableArray <UILabel *>*labels = [[NSMutableArray alloc] init];
    
    [record enumerateObjectsUsingBlock:^(NSString *content ,NSUInteger idx ,BOOL *stop){
        float colWidth = [self.columnsWidths[idx] floatValue];	//colwidth as given at setup
        CGRect rect = CGRectMake(dx, self.dy, colWidth, rowHeight);
        
        if(idx > 0){
            rect.origin.x -= idx;
        }
        
        //--------------------------------------------
        
        UILabel* col1 = [[UILabel alloc] init];
        [col1.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
        [col1.layer setBorderWidth:1.0];
        col1.font = [UIFont systemFontOfSize:16.0f];
        col1.frame = rect;
        
        NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.alignment = NSTextAlignmentNatural;
        style.headIndent = 10;
        style.firstLineHeadIndent = 10.0;
        style.tailIndent = -10.0;
        style.alignment = NSTextAlignmentCenter;
        
        if(self.numRows == 0){
            col1.backgroundColor = [UIColor whiteColor];
        }
        
        
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:content
                                                                       attributes:@{ NSParagraphStyleAttributeName : style}];
        
        
        col1.lineBreakMode = NSLineBreakByCharWrapping;
        col1.numberOfLines = 0;
        col1.attributedText = attrText;
        [col1 sizeToFit];
        
        CGFloat h = col1.frame.size.height + 10;
        if(h > rowHeight){
            rowHeight = h;
        }
        
        rect.size.width = colWidth;
        col1.frame = rect;
        
        [labels addObject:col1];
        
        dx += colWidth;

    }];
    
    [labels enumerateObjectsUsingBlock:^(UILabel *label ,NSUInteger idx ,BOOL *stop){
        CGRect tempRect = label.frame;
        tempRect.size.height = rowHeight;
        label.frame = tempRect;
        [self addSubview:label];
    }];
    
    _numRows++;
    _dy += rowHeight-1;
    
    CGRect tempRect = self.frame;
    tempRect.size.height = self.dy;
    self.frame = tempRect;
}

@end
