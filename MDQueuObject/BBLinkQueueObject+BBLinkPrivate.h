//
//  BBLinkQueueObject+BBLinkPrivate.h
//  BBLink
//
//  Created by Jave on 2017/12/8.
//  Copyright © 2017年 bilibili. All rights reserved.
//

#import "BBLinkQueueObject.h"

@class RACTargetQueueScheduler;
@interface BBLinkQueueObject (BBLinkPrivate)

@property (nonatomic, strong, readonly) RACTargetQueueScheduler *scheduler;

@end
