//
//  BBLinkQueueObject.h
//  BBLink
//
//  Created by Jave on 2017/9/25.
//  Copyright © 2017年 bilibili. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBLinkQueueObject : NSObject{
    dispatch_queue_t _queue;
}

@property (nonatomic, strong, readonly) dispatch_queue_t queue;

- (void)async:(dispatch_block_t)block;

- (void)sync:(dispatch_block_t)block;

@end
