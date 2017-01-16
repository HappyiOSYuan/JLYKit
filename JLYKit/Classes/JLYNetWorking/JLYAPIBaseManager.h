//
//  RTAPIBaseManager.h
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JLYKit/JLYURLResponse.h>

#define JLYDATAERROR [NSError errorWithDomain:@"获取错误" code:20151217 userInfo:nil]

NS_ASSUME_NONNULL_BEGIN
@class JLYAPIBaseManager;

// 在调用成功之后的params字典里面，用这个key可以取出requestID
static NSString * const kRTAPIBaseManagerRequestID = @"kJLYAPIBaseManagerRequestID";

/*!
 *  @brief api回调
 */
@protocol JLYAPIManagerApiCallBackDelegate <NSObject>
@required
- (void)managerCallAPIDidSuccess:(__kindof JLYAPIBaseManager *)manager;
- (void)managerCallAPIDidFailed:(__kindof JLYAPIBaseManager *)manager;
@end
/*!
 *  @brief 请求数据格式化处理
 */
@protocol JLYAPIManagerCallbackDataReformer <NSObject>
@required
- (id)manager:(__kindof JLYAPIBaseManager *)manager reformData:(id _Nullable)data;
@end





/*!
 *  @brief 用于验证API的返回或者调用API的参数是否正确
 */
@protocol JLYAPIManagerValidator <NSObject>
@required
- (BOOL)manager:(__kindof JLYAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary<NSString * ,id>* _Nullable)data;
- (BOOL)manager:(__kindof JLYAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary<NSString * ,id>* _Nullable)data;
@end

/*!
 *  @brief 让manager能够获取调用API所需要的数据
 */
@protocol JLYAPIManagerParamSourceDelegate <NSObject>
@required
- (NSDictionary * _Nullable)paramsForApi:(JLYAPIBaseManager *)manager;
@end

typedef NS_ENUM (NSUInteger, JLYAPIManagerErrorType){
    JLYAPIManagerErrorTypeDefault,       //没有产生过API请求，这个是manager的默认状态。
    JLYAPIManagerErrorTypeSuccess,       //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    JLYAPIManagerErrorTypeNoContent,     //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    JLYAPIManagerErrorTypeParamsError,   //参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    JLYAPIManagerErrorTypeTimeout,       //请求超时。JLYApiProxy设置的是20秒超时，具体超时时间的设置请自己去看RTApiProxy的相关代码。
    JLYAPIManagerErrorTypeNoNetWork      //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
};

typedef NS_ENUM (NSUInteger, JLYAPIManagerRequestType){
    JLYAPIManagerRequestTypeGet,
    JLYAPIManagerRequestTypePost,
    JLYAPIManagerRequestTypeImage,
    JLYAPIManagerRequestTypeRestGet,
    JLYAPIManagerRequestTypeRestPost
};


/*
 RTAPIBaseManager的派生类必须符合这些protocal
 */
@protocol JLYAPIManager <NSObject>
/*
 总述：
 这个base manager是用于给外部访问API的时候做的一个基类。任何继承这个基类的manager都要添加两个getter方法：
 
 - (NSString *)methodName
 {
 return @"community.searchMap";
 }
 
 - (RTServiceType)serviceType
 {
 return kJLYServiceManager;
 }
 
 外界在使用manager的时候，如果需要调api，只要调用loadData即可。manager会去找paramSource来获得调用api的参数。调用成功或失败，则会调用delegate的回调函数。
 
 继承的子类manager可以重载basemanager提供的一些方法，来实现一些扩展功能。具体的可以看m文件里面对应方法的注释。
 */
@required
- (NSString *)methodName;
- (NSString *)serviceType;
- (JLYAPIManagerRequestType)requestType;

@optional
- (void)cleanData;
- (NSDictionary<NSString * ,id>* _Nullable)reformParams:(NSDictionary<NSString * ,id>* _Nullable)params;
- (BOOL)shouldCache;

@end

/*
 RTAPIBaseManager的派生类必须符合这些protocal
 */
@protocol JLYAPIManagerInterceptor <NSObject>

@optional
- (void)manager:(__kindof JLYAPIBaseManager *)manager beforePerformSuccessWithResponse:(JLYURLResponse *)response;
- (void)manager:(__kindof JLYAPIBaseManager *)manager afterPerformSuccessWithResponse:(JLYURLResponse *)response;

- (void)manager:(__kindof JLYAPIBaseManager *)manager beforePerformFailWithResponse:(JLYURLResponse *)response;
- (void)manager:(__kindof JLYAPIBaseManager *)manager afterPerformFailWithResponse:(JLYURLResponse *)response;

- (BOOL)manager:(__kindof JLYAPIBaseManager *)manager shouldCallAPIWithParams:(NSDictionary<NSString * ,id>* _Nullable)params;
- (void)manager:(__kindof JLYAPIBaseManager *)manager afterCallingAPIWithParams:(NSDictionary<NSString * ,id>* _Nullable)params;

@end




@interface JLYAPIBaseManager : NSObject

@property (nonatomic, weak) id<JLYAPIManagerApiCallBackDelegate> delegate;
@property (nonatomic, weak) id<JLYAPIManagerParamSourceDelegate> paramSource;
@property (nonatomic, weak) id<JLYAPIManagerValidator> validator;
@property (nonatomic, weak) NSObject<JLYAPIManager> *child; //里面会调用到NSObject的方法，所以这里不用id
@property (nonatomic, weak) id<JLYAPIManagerInterceptor> interceptor;

/*
 baseManager是不会去设置errorMessage的，派生的子类manager可能需要给controller提供错误信息。所以为了统一外部调用的入口，设置了这个变量。
 派生的子类需要通过extension来在保证errorMessage在对外只读的情况下使派生的manager子类对errorMessage具有写权限。
 */
@property (nonatomic, copy, readonly) NSString *errorMessage;
@property (nonatomic, readonly) JLYAPIManagerErrorType errorType;

@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL isLoading;

- (id _Nullable)fetchDataWithReformer:(id<JLYAPIManagerCallbackDataReformer> _Nullable)reformer;

//尽量使用loadData这个方法,这个方法会通过param source来获得参数，这使得参数的生成逻辑位于controller中的固定位置
- (NSInteger)loadData;

- (void)cancelAllRequests;
- (void)cancelRequestWithRequestId:(NSInteger)requestID;

// 拦截器方法，继承之后需要调用一下super
- (void)beforePerformSuccessWithResponse:(JLYURLResponse *)response;
- (void)afterPerformSuccessWithResponse:(JLYURLResponse *)response;

- (void)beforePerformFailWithResponse:(JLYURLResponse *)response;
- (void)afterPerformFailWithResponse:(JLYURLResponse *)response;

- (BOOL)shouldCallAPIWithParams:(NSDictionary<NSString * ,id>* _Nullable)params;
- (void)afterCallingAPIWithParams:(NSDictionary<NSString * ,id>* _Nullable)params;

/*
 用于给继承的类做重载，在调用API之前额外添加一些参数,但不应该在这个函数里面修改已有的参数。
 子类中覆盖这个函数的时候就不需要调用[super reformParams:params]了
 JLYAPIBaseManager会先调用这个函数，然后才会调用到 id<JLYAPIManagerValidator> 中的 manager:isCorrectWithParamsData:
 所以这里返回的参数字典还是会被后面的验证函数去验证的。
 
 假设同一个翻页Manager，ManagerA的paramSource提供page_size=15参数，ManagerB的paramSource提供page_size=2参数
 如果在这个函数里面将page_size改成10，那么最终调用API的时候，page_size就变成10了。然而外面却觉察不到这一点，因此这个函数要慎用。
 
 这个函数的适用场景：
 当两类数据走的是同一个API时，为了避免不必要的判断，我们将这一个API当作两个API来处理。
 那么在传递参数要求不同的返回时，可以在这里给返回参数指定类型。
 
 */
- (NSDictionary<NSString * ,id>* _Nullable)reformParams:(NSDictionary<NSString * ,id>* _Nullable)params;
- (void)cleanData;
- (BOOL)shouldCache;

@end
NS_ASSUME_NONNULL_END
