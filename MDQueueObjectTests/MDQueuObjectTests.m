//
//  MDQueueObjectTests.m
//  MDQueueObjectTests
//
//  Created by Jave on 2017/12/15.
//  Copyright © 2017年 markejave. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MDQueueObject.h"

@interface MDQueueObjectTests : XCTestCase

@property (nonatomic, strong, readonly) MDQueueObject *queueObject;

@property (nonatomic, strong, readonly) MDQueueObject *namedQueueObject;

@end

@implementation MDQueueObjectTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _queueObject = [[MDQueueObject alloc] init];
    _namedQueueObject = [[MDQueueObject alloc] initWithName:@"Test"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSynchroinze {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    __block BOOL state = NO;
    [[self queueObject] sync:^{
        state = YES;
    }];
    
    XCTAssertTrue(state, @"Failed to process synchronized operation.");
    
    state = NO;
    [[self namedQueueObject] sync:^{
        state = YES;
    }];
    
    XCTAssertTrue(state, @"Failed to process synchronized operation.");
}

- (void)testAsynchroinze {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"High.Expectations"];
    __block BOOL state = NO;
    [[self queueObject] async:^{
        state = YES;
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError *error) {
        XCTAssertTrue(state, @"Failed to process synchronized operation.");
        XCTAssertNil(error, @"Failed to process synchronized operation.");
    }];
    
    expectation = [self expectationWithDescription:@"High.Expectations"];
    state = NO;
    [[self namedQueueObject] async:^{
        state = YES;
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError *error) {
        XCTAssertTrue(state, @"Failed to process synchronized operation.");
        XCTAssertNil(error, @"Failed to process synchronized operation.");
    }];
}

@end
