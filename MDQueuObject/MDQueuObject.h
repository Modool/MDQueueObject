//
//  MDQueuObject.h
//  MDQueuObject
//
//  Created by Jave on 2017/12/15.
//  Copyright © 2017年 markejave. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for MDQueuObject.
FOUNDATION_EXPORT double MDQueuObjectVersionNumber;

//! Project version string for MDQueuObject.
FOUNDATION_EXPORT const unsigned char MDQueuObjectVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <MDQueuObject/PublicHeader.h>

#import <Foundation/Foundation.h>

@interface MDQueuObject : NSObject

@property (nonatomic, strong, readonly) dispatch_queue_t queue;

- (instancetype)initWithName:(NSString *)name NS_DESIGNATED_INITIALIZER;

- (void)async:(dispatch_block_t)block;

- (void)sync:(dispatch_block_t)block;

@end
