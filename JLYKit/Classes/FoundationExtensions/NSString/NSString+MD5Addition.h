/*!
 @header Baby
 @abstract 电子商务
 @author 宁袁
 @version 1.00 2014/03 Creation
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*!
 @category 
 @abstract NSString类别，做MD5转换
 */
@interface NSString(MD5Addition)
/*!
 *  @brief md5加密
 *
 *  @return 加密结果
 */
- (NSString *)jly_stringFromMD5;

@end
NS_ASSUME_NONNULL_END