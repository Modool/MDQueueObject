//
//  MDQueuObject.h
//  MDQueuObject
//
//  Created by Jave on 2017/12/15.
//  Copyright © 2017年 markejave. All rights reserved.
//

#import "MDQueuObject.h"

NSString * const MDQueuObjectDomainPrefix = @"com.modool.queue.object#";

@interface MDQueuObject ()

@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, assign) void *queueTag;

@end

@implementation MDQueuObject

- (instancetype)init {
    return [self initWithName:[NSString stringWithFormat:@"%@%lu", MDQueuObjectDomainPrefix, (unsigned long)self]];
}

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.queueTag = &_queueTag;
        self.queue = dispatch_queue_create([[MDQueuObjectDomainPrefix stringByAppendingString:name] UTF8String], NULL);
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
