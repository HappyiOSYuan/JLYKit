/*!
 @header JLYLocationManager
 @abstract 电子商务
 @author 宁袁
 @version 1.00 2014/03 Creation
 */
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^LocationBlock)(CLLocationCoordinate2D locationCorrrdinate);
typedef void (^LocationErrorBlock) (NSError *error);
typedef void(^NSStringBlock)(NSString *cityString);
typedef void(^NSStringBlock)(NSString *addressString);
typedef void(^AreaBlock)(NSString *cityString ,CLLocationCoordinate2D locationCorrrdinate ,NSString *placename);
/*!
 @class
 @abstract 地图定位类
 */
@interface JLYLocation : NSObject<CLLocationManagerDelegate>
/*!
 @property
 @abstract MKMapView类
 */
@property (nonatomic,strong) CLLocationManager *mapView;
/*!
 @property
 @abstract MKMapView类
 */
@property (nonatomic) CLLocationCoordinate2D lastCoordinate;
/*!
 @property
 @abstract 当前城市
 */
@property (nonatomic,strong)NSString *lastCity;
/*!
 @property
 @abstract 当前街道信息
 */
@property (nonatomic,strong) NSString *lastAddress;
/*!
 @property
 @abstract 纬度
 */
@property (nonatomic,assign) float latitude;
/*!
 @property
 @abstract 经度
 */
@property (nonatomic,assign) float longitude;
@property (nonatomic ,copy) CLLocation *userLocaiton;
/*!
 @method
 @abstract JLYLocationManager 单例
 @return JLYLocationManager
 */
+ (JLYLocation *)shareLocation;
/*!
 @method
 @abstract 获取坐标
 @param locaiontBlock locaiontBlock description
 */
- (void) getLocationCoordinate:(LocationBlock) locaiontBlock ;
/*!
 @method
 @abstract 获取坐标和地址
 @param locaiontBlock locaiontBlock description
 @param addressBlock  addressBlock description
 */
- (void) getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(NSStringBlock) addressBlock;
/*!
 @method
 @abstract 获取地址
 @param addressBlock addressBlock description
 */
- (void) getAddress:(NSStringBlock)addressBlock;
/*!
 @method
 @abstract 获取城市
 @param cityBlock cityBlock description
 */
- (void) getCity:(NSStringBlock)cityBlock;
/*!
 @method
 @abstract 获取城市和定位失败
 @param cityBlock  cityBlock description
 @param errorBlock errorBlock description
 */
- (void) getCity:(AreaBlock)areaBlock error:(LocationErrorBlock) errorBlock;

@end
NS_ASSUME_NONNULL_END
