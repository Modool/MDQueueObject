//
//  MDQueueObject.h
//  MDQueueObject
//
//  Created by Jave on 2017/12/15.
//  Copyright © 2017年 markejave. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for MDQueueObject.
FOUNDATION_EXPORT double MDQueueObjectVersionNumber;

//! Project version string for MDQueueObject.
FOUNDATION_EXPORT const unsigned char MDQueueObjectVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <MDQueueObject/PublicHeader.h>

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString * const MDQueueObjectDomainPrefix;

@interface MDQueueObject : NSObject

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, strong, readonly) dispatch_queue_t queue;

- (instancetype)initWithName:(NSString *)name NS_DESIGNATED_INITIALIZER;

- (void)async:(dispatch_block_t)block;

- (void)sync:(dispatch_block_t)block;

@end
