//
//  MDQueuObjectTests.m
//  MDQueuObjectTests
//
//  Created by Jave on 2017/12/15.
//  Copyright © 2017年 markejave. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MDQueuObject.h"

@interface MDQueuObjectTests : XCTestCase

@property (nonatomic, strong, readonly) MDQueuObject *queueObject;

@property (nonatomic, strong, readonly) MDQueuObject *namedQueueObject;

@end

@implementation MDQueuObjectTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _queueObject = [[MDQueuObject alloc] init];
    _namedQueueObject = [[MDQueuObject alloc] initWithName:@"Test"];
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
