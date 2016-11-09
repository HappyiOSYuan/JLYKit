//
//  JLYNavigationSubtitleView.h
//  Pods
//
//  Created by mac on 2016/11/9.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface JLYNavigationSubtitleView : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, assign) NSInteger spacing;

@property (nonatomic, strong, nullable) UIColor *titleColor;
@property (nonatomic, strong, nullable) UIColor *subtitleColor;

@property (nonatomic, strong, nullable) UIFont *regularTitleFont;
@property (nonatomic, strong, nullable) UIFont *compactTitleFont;

@property (nonatomic, strong, nullable) UIFont *regularSubtitleFont;
@property (nonatomic, strong, nullable) UIFont *compactSubtitleFont;

@property (nonatomic, assign) BOOL animateChanges;


@property (nonatomic, strong, nullable) UIView *subtitleView;
@property (nonatomic, weak) UIViewController *viewController;
@end

NS_ASSUME_NONNULL_END
