//
//  AsynchronousOperation.h
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface AsynchronousOperation : NSOperation

/// Complete the asynchronous operation.
///
/// This also triggers the necessary KVO to support asynchronous operations.

- (void)completeOperation;

@end
NS_ASSUME_NONNULL_END