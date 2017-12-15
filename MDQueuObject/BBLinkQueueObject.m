//
//  BBLinkQueueObject.m
//  BBLink
//
//  Created by Jave on 2017/9/25.
//  Copyright © 2017年 bilibili. All rights reserved.
//

#import "BBLinkQueueObject.h"
#import "BBLinkQueueObject+BBLinkPrivate.h"

NSString * const BBLinkAccessorDomainPrefix = @"com.bilibili.queue.object#";

@interface BBLinkQueueObject ()

@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, assign) void *queueTag;

@property (nonatomic, strong) RACTargetQueueScheduler *scheduler;

@end

@implementation BBLinkQueueObject

- (instancetype)init{
    if (self = [super init]) {
        
        NSString *queueName = [BBLinkAccessorDomainPrefix stringByAppendingString:NSStringFromClass([self class])];
        self.queue = dispatch_queue_create([queueName UTF8String], NULL);
        self.scheduler = [[RACTargetQueueScheduler alloc] initWithName:queueName targetQueue:[self queue]];
        
        self.queueTag = &_queueTag;
        dispatch_queue_set_specific([self queue], _queueTag, _queueTag, NULL);
    }
    return self;
}

- (void)async:(dispatch_block_t)block;{
    if (dispatch_get_specific(_queueTag)) {
        block();
    } else {
        dispatch_async([self queue], block);
    }
}

- (void)sync:(dispatch_block_t)block;{
    if (dispatch_get_specific(_queueTag)) {
        block();
    } else {
        dispatch_sync([self queue], block);
    }
}

@end
