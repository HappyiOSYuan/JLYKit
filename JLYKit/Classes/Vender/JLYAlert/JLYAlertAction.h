//
//  JLYAlertAction.h
//  Alert Controller Test
//
//  Created by Tanner on 12/3/14.
//  Copyright (c) 2014 Tanner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///-------------------
/// @name Block types
///-------------------

/** A void returning block that takes no parameters. */
typedef void (^JLYVoidBlock)(void);
/** A void returning block that takes an array of strings representing the text in each of the text fields of the associated \c JLYAlertController.
 If there were no text fields, or if the alert controller style was \c JLYAlertControllerStyleActionSheet the array is empty and can be ignored. */
typedef void (^JLYAlertActionBlock)(NSArray *textFieldStrings);

/** All possible action styles (no action, block, target-selector, and single-parameter target-selector). */
typedef NS_ENUM(NSInteger, JLYAlertActionStyle) {
    JLYAlertActionStyleNoAction = 0,
    JLYAlertActionStyleBlock,
    JLYAlertActionStyleTarget,
    JLYAlertActionStyleTargetObject
};

/** This class provides a way to add actions to a \c JLYAlertController similar to how actions are added to \c UIAlertController.
 All actions added to a \c JLYAlertController are converted to \c JLYAlertActions. Any \c JLYAlertController is safe to use after being properly initialized. */
@interface JLYAlertAction : NSObject

///------------------
/// @name Properties
///------------------

/** The style of the action. */
@property (nonatomic, readonly                ) JLYAlertActionStyle style;
/** The block to be executed when the action is triggered, if it's style is \c JLYAlertActionStyleBlock. */
@property (nonatomic, readonly, copy, nullable) JLYAlertActionBlock block;
/** Whether or not the action is enabled.
 @warning This is a feature of \c UIAlertAction and is ignored on iOS 7. */
@property (nonatomic                    ) BOOL     enabled;
/** The title of the action, displayed on the button representing it. */
@property (nonatomic, readonly, copy    ) NSString *title;
/** The target of the \c action property. \c nil if it's style is not \c JLYAlertActionStyleTarget or \c JLYAlertActionStyleTargetObject. */
@property (nonatomic, readonly, nullable) id       target;
/** The selector called on the \c target property when triggered. \c nil if it's style is not \c JLYAlertActionStyleTarget or \c JLYAlertActionStyleTargetObject. */
@property (nonatomic, readonly, nullable) SEL      action;
/** The object used when the \c style property is \c JLYAlertActionStyleTargetObject. */
@property (nonatomic, readonly, nullable) id       object;


///--------------------
/// @name Initializers
///--------------------

/** Initializes a \c JLYAlertAction with the given title. */
- (id)initWithTitle:(NSString *)title;
/** Initializes a \c JLYAlertAction with the given title and a block to execute when triggered.
 
 @param title The title of the button.
 @param block An optional block to execute when the action is triggered. */
- (id)initWithTitle:(NSString *)title block:(JLYAlertActionBlock)block;
/** Initializes a \c JLYAlertAction with the given title and a target-selector style action to execute when triggered.
 
 @param title The button title
 @param target The object to perform the \c action selector on when the action is triggered.
 @param action A selector to perform on the \c target object when the action is triggered. */
- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;
/** Initializes a \c JLYAlertAction with the given title and a target-selector style action which takes a single parameter to execute when triggered.
 
 @param title The button title
 @param target The object to perform the \c action selector on when the action is triggered.
 @param action A selector to perform on the \c target object when the action is triggered.
 @param object An object to pass to \c action. Behavior is undefined for \c nil values. */
- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action object:(nullable id)object;

///-----------------------------
/// @name Triggering the Action
///-----------------------------

/** A convenient way to programmatically trigger the action. Nothing happens if the action consists only of a title.
 
 @note This is equivalent to calling perform: and passing an empty array. */
- (void)perform;
/** A convenient way to programmatically trigger the action, supplied with an array of \c NSStrings. Nothing happens if the action consists only of a title.
 
 @param textFieldInputStrings An optional array of \c NSStrings. \c JLYAlertController uses this method when a button is tapped on an alert view with text fields. You may pass \c nil to this parameter.
 @warning Behavior is undefined if \c textFieldInputStrings contains objects other than \c NSStrings. */
- (void)perform:(nullable NSArray *)textFieldInputStrings;

NS_ASSUME_NONNULL_END

@end
