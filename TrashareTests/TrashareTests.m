//
//  TrashareTests.m
//  TrashareTests
//
//  Created by Marina Huber on 11/16/15.
//  Copyright © 2015 The App Academy. All rights reserved.
//
#import "MapAnnotation.h"
#import "HomeViewController.h"
#import <XCTest/XCTest.h>

@interface TrashareTests : XCTestCase

@end

@implementation TrashareTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testMapAnnotation {
    MapAnnotation *marina = [[MapAnnotation alloc] init];
    XCTAssert(marina != nil, @"check object is not nil");
    
}

//- (void)testDateCreated {
//    
//    NSString *dateString = [[NSDate alloc] dateOnlyForTest:trashDate];
//    XCTAssert (dateString! = NSString, @"check date is a string");
//     NSLog(@"%@",dateString);
//}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
              