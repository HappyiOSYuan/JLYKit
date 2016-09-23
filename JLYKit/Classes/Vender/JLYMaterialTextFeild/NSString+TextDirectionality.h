//
//  NSString+TextDirectionality.h
//  JLYFloatLabeledTextField
//
//  Created by TJBT on 16/6/2.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, JLYTextDirection) {
    /**
     * `JLYTextDirectionNeutral` indicates text with no directionality
     */
    JLYTextDirectionNeutral = 0,
    
    /**
     * `JLYTextDirectionLeftToRight` indicates text left-to-right directionality
     */
    JLYTextDirectionLeftToRight,
    
    /**
     * `JLYTextDirectionRightToLeft` indicates text right-to-left directionality
     */
    JLYTextDirectionRightToLeft,
};

/**
 * `NSString (TextDirectionality)` is an NSString category that is used to infer the text directionality of a string.
 */
@interface NSString (TextDirectionality)

/**
 *  Inspects the string and makes a best guess at text directionality.
 *
 *  @return the inferred text directionality of this string.
 */
- (JLYTextDirection)getBaseDirection;

@end
NS_ASSUME_NONNULL_END