//
//  JLYBaseViewController.m
//  BaseViewController
//
//  Created by mac on 16/3/14.
//  Copyright © 2016年 ningyuan. All rights reserved.
//

#import "JLYBaseViewController.h"
#import "DGActivityIndicatorView.h"
#import <Reachability/Reachability.h>
#import "JLYAppDelegate.h"

@implementation JLYNetWorkLoadingView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = backColor;
        self.alpha = 0.8f;
        [self addSubview:self.activityView];
    }
    return self;
}

- (DGActivityIndicatorView *)activityView{
    if (!_activityView) {
        _activityView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeNineDots tintColor:themeColor size:60.0f];
        _activityView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        [_activityView startAnimating];
    }
    return _activityView;
}
@end
/**
 *  定制网络变化UI
 */
@implementation JLYNetWorkChangeView

@end

@interface JLYBaseViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) JLYNetWorkChangeView  *netWorkChageView;
@property (nonatomic, strong) JLYNetWorkLoadingView *netWorkLoadingView;

@end

@implementation JLYBaseViewController
@synthesize fitViewType     = _fitViewType ;
@synthesize viewToTop       = _viewToTop;
@synthesize viewToBottom    = _viewToBottom;
@synthesize isOpenNetListen = _isOpenNetListen;
@synthesize netIsUse = _netIsUse;

#pragma mark - LifyStyle
//内存移除
- (void)dealloc{
    
}
//加载视图
- (void)loadView{
    [super loadView];
    //自定制视图
}

- (void)configSubviews{
    [self.view addSubview:self.netWorkChageView];
}

- (void)configConstraints{
    
}
//加载视图完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isOpenNetListen = YES;
    self.view.backgroundColor = backColor;
    [self fitViewWithFitViewType:self.fitViewType];
    [self configSubviews];
    [self configConstraints];
    // Do any additional setup after loading the view, typically from a nib.
}
//视图将要出现
- (void)viewWillAppear:(BOOL)animated{
    [self initializeData];
    [super viewWillAppear:animated];
    [self showLoadingUI];
}
//视图已经出现
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodger];
}
//视图将要消失
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isOpenNetListen = NO;
}
//视图已经消失
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.view unregisterAsDodgeViewForMLInputDodger];
    [self.view endEditing:YES];
    [self textResignFirstResponder];
    [self clearText];
}
//收到系统内存警告
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - SystemDelegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - PrivateMethod
/**适配带导航和不带导航--带tabBar和不带tarbar的 self.view的布局*/
- (void)fitViewWithFitViewType:(FitViewType)fitViewType{
    //填充适配条件
    [self fitCondition];
    //自动调整Insets关闭
    self.automaticallyAdjustsScrollViewInsets = NO;
    //*****************************第一种方法******************************//
    if (fitViewType == FitViewTypeDefault) {
        //当前的容器为导航控制器
        if (self.navigationController && self.navigationController.tabBarController == nil) {
            _viewToBottom = 0.0f;
            //导航条隐藏
            if (self.navigationController.isNavigationBarHidden) {
                _viewToTop = 20.0f;
                //导航条显示
            }else{
                //导航条透明
                if (self.navigationController.navigationBar.isTranslucent) {
                    _viewToTop = 64.0f;
                }else{
                    self.extendedLayoutIncludesOpaqueBars = YES;
                    _viewToTop = 64.0f;
                }
            }
            //当前的容器是tabBar控制器
        }else if (self.navigationController == nil && self.tabBarController){
            _viewToTop = 20.0f;
            //tabBar隐藏
            if (self.tabBarController.tabBar.isHidden) {
                _viewToBottom = 0.0f;
                //tabBar显示
            }else{
                _viewToBottom = 49.0f;
            }
            //当前容器的容器是tabBar的控制器
        }else if (self.navigationController && self.navigationController.tabBarController){
            
            //导航条显示 tabBar显示
            if (self.navigationController.isNavigationBarHidden == NO
                && self.navigationController.tabBarController.tabBar.isHidden == NO && self.hidesBottomBarWhenPushed == NO) {
                _viewToBottom =  49.0f;
                //导航条透明
                if (self.navigationController.navigationBar.isTranslucent) {
                    _viewToTop = 64.0f;
                }else{
                    self.extendedLayoutIncludesOpaqueBars = YES;
                    _viewToTop = 64.0f;
                }
                //导航条隐藏 tarBar隐藏
            }else if (self.navigationController.isNavigationBarHidden
                      && (self.navigationController.tabBarController.tabBar.isHidden | self.hidesBottomBarWhenPushed)){
                
                _viewToTop = 20.0f;
                _viewToBottom = 0.0f;
                
                //导航条显示 tarBar隐藏
            }else if (self.navigationController.isNavigationBarHidden == NO
                      && (self.tabBarController.tabBar.isHidden
                          || self.hidesBottomBarWhenPushed)){
                          //导航条透明
                          if (self.navigationController.navigationBar.isTranslucent) {
                              _viewToTop = 64.0f;
                          }else{
                              self.extendedLayoutIncludesOpaqueBars = YES;
                              _viewToTop = 64.0f;
                          }
                          _viewToBottom = 0.0f;
                          //导航条隐藏 tabBar显示
                      }else{
                          
                          _viewToTop = 20.0f;
                          _viewToBottom = 49.0f;
                      }
            //当前没有容器
        }else{
            _viewToTop =  20.0f;
            _viewToBottom = 0.0f;
        }
        //*****************************第二种方法******************************//
    }else{
        
        _viewToBottom = 0.0f;
        //1当前的容器是导航控制器
        if (self.navigationController && self.navigationController.tabBarController == nil) {
            
            //导航条隐藏
            if (self.navigationController.navigationBarHidden) {
                self.edgesForExtendedLayout = UIRectEdgeAll;
                self.extendedLayoutIncludesOpaqueBars = YES;
                _viewToTop =  20.0f;
                
                //导航条没有隐藏
            }else{
                //导航条透明
                if (self.navigationController.navigationBar.isTranslucent) {
                    self.edgesForExtendedLayout = UIRectEdgeAll;
                    self.extendedLayoutIncludesOpaqueBars = YES;
                    _viewToTop = 20.0f;
                    //导航条不透明
                }else{
                    self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight |  UIRectEdgeBottom;
                    self.extendedLayoutIncludesOpaqueBars = NO;
                    _viewToTop = 0.0f;
                }
            }
            //2当前容器的容器是TabBarController
        }else if (self.navigationController && self.navigationController.tabBarController){
            
            //*****************************start******************************//
            //1）导航条显示 tabBar显示
            if (self.navigationController.isNavigationBarHidden == NO
                && self.navigationController.tabBarController.tabBar.isHidden == NO) {
                //导航条透明
                if (self.navigationController.navigationBar.isTranslucent) {
                    self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight |UIRectEdgeTop;
                    self.extendedLayoutIncludesOpaqueBars = YES;
                    _viewToTop = 20.0f;
                }else{
                    self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight ;
                    self.extendedLayoutIncludesOpaqueBars = NO;
                    _viewToTop = 0.0f;
                }
                //2）导航条显示 tabBar隐藏
            }else if (self.navigationController.isNavigationBarHidden == NO
                      && (self.navigationController.tabBarController.tabBar.hidden
                          || self.hidesBottomBarWhenPushed)){
                          
                          //导航条透明
                          if (self.navigationController.navigationBar.isTranslucent) {
                              self.edgesForExtendedLayout = UIRectEdgeAll;
                              self.extendedLayoutIncludesOpaqueBars = YES;
                              _viewToTop = 20.0f;
                              //导航条不透明
                          }else{
                              self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight | UIRectEdgeBottom;
                              self.extendedLayoutIncludesOpaqueBars = NO;
                              _viewToTop = 0.0f;
                          }
                          //3）导航条隐藏 tabBar显示
                      }else if (self.navigationController.isNavigationBarHidden
                                && (self.navigationController.tabBarController.tabBar.isHidden == NO
                                    || self.hidesBottomBarWhenPushed == NO)){
                                    self.edgesForExtendedLayout = UIRectEdgeTop | UIRectEdgeLeft | UIRectEdgeRight;
                                    self.extendedLayoutIncludesOpaqueBars= YES;
                                    _viewToTop = 20.0f;
                                    //4）导航条隐藏 taBar隐藏
                                }else{
                                    self.edgesForExtendedLayout = UIRectEdgeAll;
                                    _viewToTop = 20.0f;
                                }
            //*****************************end******************************//
            
            //3当前的容器tarBarController
        }else if (self.navigationController == nil && self.tabBarController){
            //tabBar隐藏
            if (self.tabBarController.tabBar.isHidden ) {
                self.edgesForExtendedLayout = UIRectEdgeAll;
                //tabBar显示
            }else{
                self.edgesForExtendedLayout = UIRectEdgeRight | UIRectEdgeLeft | UIRectEdgeTop;
            }
            _viewToTop = 20.0f;
            //4没有容器
        }else{
            self.edgesForExtendedLayout = UIRectEdgeAll;
            self.extendedLayoutIncludesOpaqueBars = YES;
            _viewToTop = 20.0f;
        }
    }
}

// 适配条件 留个接口子类继承重写
- (void)fitCondition{
    //TODO: 子类重写
}

- (void)textResignFirstResponder{
    [self.view.subviews enumerateObjectsUsingBlock:^(UIView *view ,NSUInteger idx ,BOOL *stop){
        if ([view respondsToSelector:@selector(resignFirstResponder)]) {
            [view performSelector:@selector(resignFirstResponder)];
        }
        if ([view isKindOfClass:[UIScrollView class]]) {
            [view.subviews enumerateObjectsUsingBlock:^(UIView *view ,NSUInteger idx ,BOOL *stop){
                if ([view respondsToSelector:@selector(resignFirstResponder)]) {
                    [view performSelector:@selector(resignFirstResponder)];
                }
            }];
        }
    }];
}

- (void)clearText{
    [self.view.subviews enumerateObjectsUsingBlock:^(UIView *view ,NSUInteger idx ,BOOL *stop){
        if ([view respondsToSelector:@selector(setText:)]) {
            [view performSelector:@selector(setText:) withObject:nil];;
        }
        if ([view isKindOfClass:[UIScrollView class]]) {
            [view.subviews enumerateObjectsUsingBlock:^(UIView *view ,NSUInteger idx ,BOOL *stop){
                if ([view respondsToSelector:@selector(setText:)]) {
                    [view performSelector:@selector(setText:) withObject:nil];;
                }
            }];
        }
    }];
}
//打开网络监听or关闭网络监听
- (void)reachabilityChanged:(NSNotification *)note{
    Reachability *curReach = [note object];
    [self netWorkChange:curReach];
}

- (void)netWorkChange:(Reachability*)curReach{
    switch ([curReach currentReachabilityStatus]) {
        case NotReachable:{
            [self.netWorkChageView setTitle:@"网络不可用,亲 ->点击设置网络连接!" forState:UIControlStateNormal];
            [self.view bringSubviewToFront:self.netWorkChageView];
            self.netWorkChageView.enabled = YES;
            [UIView animateWithDuration:1.5f animations:^{
                self.netWorkChageView.alpha = 1;
            } completion:^(BOOL finished) {
                self.netWorkChageView.hidden= NO;
            }];
            _netIsUse = NO;
        }
            break;
        case ReachableViaWiFi:{ //wifi he WWAN一样
            
        }
        case ReachableViaWWAN:{
            [self.netWorkChageView setTitle:@"网络已链接^^!" forState:UIControlStateNormal];
            //网络可用不用点击
            self.netWorkChageView.enabled = NO;
            [UIView animateWithDuration:1.5f animations:^{
                self.netWorkChageView.alpha = 0;
            } completion:^(BOOL finished) {
                self.netWorkChageView.hidden= YES;
            }];
            _netIsUse = YES;
        }
            break;
    }
}

- (void)goNetNotUse:(UIButton *)sender{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}
#pragma mark - PublicMethod
- (void)showLoadingUI{
    self.netWorkLoadingView.hidden = NO;
    self.netWorkLoadingView.alpha = 1;
    [self.netWorkLoadingView.activityView startAnimating];
}

- (void)hideLoadingUI{
    if (self.netWorkLoadingView && !self.netWorkLoadingView.hidden) {
        [UIView animateWithDuration:0.3f animations:^{
            self.netWorkLoadingView.alpha = 0;
        }completion:^(BOOL finished){
            [self.netWorkLoadingView.activityView stopAnimating];
            self.netWorkLoadingView.hidden = YES;
        }];
    }
}

- (void)initializeData{
    
}
#pragma mark - SettersAndGetters
- (FitViewType)fitViewType{
    _fitViewType = FitViewTypeDefault;
    return _fitViewType;
    //TODO: 子类需要哪种就写哪种 默认是第一种
}

- (void)setIsOpenNetListen:(BOOL)isOpenNetListen{
    _isOpenNetListen = isOpenNetListen;
    if (_isOpenNetListen) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChanged:)
                                                     name:kReachabilityChangedNotification object:nil];
        JLYAppDelegate *appDelegate = (JLYAppDelegate *)[UIApplication sharedApplication].delegate;
        //在appDelegate中监测网络变化 刚打开应用时网络变化 self还没被实例化 因此收不到网络变化 必须强制 监测一下
        //网络可用不显示 不可用显示
        if ([appDelegate.reach currentReachabilityStatus] ==  NotReachable) {
            [self netWorkChange:appDelegate.reach];
        }
    }else{
        //移除网络监听
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:kReachabilityChangedNotification
                                                      object:nil];
        if (!_netWorkChageView) {
            [_netWorkChageView removeFromSuperview];
            _netWorkChageView = nil;
        }
    }
}

- (JLYNetWorkLoadingView *)netWorkLoadingView{
    if (!_netWorkLoadingView) {
        _netWorkLoadingView = [[JLYNetWorkLoadingView alloc] initWithFrame:CGRectMake(0.0f, _viewToTop, self.view.frame.size.width, self.view.frame.size.height - _viewToTop - _viewToBottom)];
        [self.view addSubview:_netWorkLoadingView];
    }
    return _netWorkLoadingView;
}

- (JLYNetWorkChangeView *)netWorkChageView{
    if (!_netWorkChageView) {
        //判断当前的容器为导航控制器
        CGFloat start_Y = 64;
        if (self.navigationController) {
            //导航控制器隐藏
            if (self.navigationController.isNavigationBarHidden) {
                start_Y = 20;
            }
            //当前的容器不是导航控制器
        }else{
            start_Y = 20;
        }
        _netWorkChageView = ({
            JLYNetWorkChangeView *changeView = [JLYNetWorkChangeView buttonWithType:UIButtonTypeCustom];
            changeView.frame = CGRectMake(0, start_Y, self.view.frame.size.width, 30.0f);
            changeView.layer.borderColor =  [UIColor purpleColor].CGColor;
            changeView.layer.borderWidth = 1.0f;
            changeView.backgroundColor = [UIColor colorWithRed:1.000 green:0.983 blue:0.530 alpha:1.000];
            changeView.titleLabel.font = font(14.0f);
            [changeView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [changeView addTarget:self
                           action:@selector(goNetNotUse:)
                 forControlEvents:UIControlEventTouchUpInside];
            [changeView setTitleColor:RGBA(255.0f, 58.0f, 49.0f, 1.0f)
                             forState:UIControlStateNormal];
            changeView.alpha = 0;
            changeView.hidden =  YES;
            changeView.enabled = NO;
            changeView;
        });
    }
    return _netWorkChageView;
}

@end
