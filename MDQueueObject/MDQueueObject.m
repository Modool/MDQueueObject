//
//  MDQueueObject.h
//  MDQueueObject
//
//  Created by Jave on 2017/12/15.
//  Copyright © 2017年 markejave. All rights reserved.
//

#import "MDQueueObject.h"

NSString * const MDQueueObjectDomainPrefix = @"com.modool.queue.object#";

@interface MDQueueObject ()

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) dispatch_queue_t queue;

@property (nonatomic, assign) void *queueTag;

@end

@implementation MDQueueObject

- (instancetype)init {
    return [self initWithName:[NSString stringWithFormat:@"%@%@#%lu", MDQueueObjectDomainPrefix, NSStringFromClass(self.class), (unsigned long)self]];
}

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.name = name;
        self.queueTag = &_queueTag;
        self.queue = dispatch_queue_create([name UTF8String], NULL);
        
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
