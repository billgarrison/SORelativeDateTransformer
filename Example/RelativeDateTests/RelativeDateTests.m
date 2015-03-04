//
//  RelativeDateTests.m
//  RelativeDateTests
//
//  Created by Chaitanya Kumar Kamatham on 3/3/15.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SORelativeDateTransformer.h"

@interface RelativeDateTests : XCTestCase

@end

@implementation RelativeDateTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testNow {
    
    XCTAssertEqualObjects(@"now", [[SORelativeDateTransformer registeredTransformer] transformedValue:[NSDate date]]);
}

- (void)testInSecond {
    // This is an example of a functional test case.
    
    XCTAssertEqualObjects(@"in 1 second", [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:2]]);
}

- (void)testInSeconds {
    // This is an example of a functional test case.
    
    XCTAssertEqualObjects(@"in 2 seconds", [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:3]]);
}

- (void)testInMinute {
    // This is an example of a functional test case.
    
    XCTAssertEqualObjects(@"in 1 minute", [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:61]]);
}

- (void)testInMinutes {
    // This is an example of a functional test case.
    
    XCTAssertEqualObjects(@"in 2 minutes", [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:121]]);
}

- (void)testInHour {
    // This is an example of a functional test case.
    
    XCTAssertEqualObjects(@"in 1 hour", [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:3601]]);
}

- (void)testInHours {
    // This is an example of a functional test case.
    
    XCTAssertEqualObjects(@"in 2 hours", [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:7201]]);
}

- (void)testInDay {
    // This is an example of a functional test case.
    
    XCTAssertEqualObjects(@"in 1 day", [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:60 * 60 * 24 + 1]]);
}

- (void)testInDays {
    // This is an example of a functional test case.
    
    XCTAssertEqualObjects(@"in 2 days", [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:60 * 60 * 24 * 2 + 1]]);
}


- (void)testSecondAgo {
    // This is an example of a functional test case.
    
    XCTAssertEqualObjects(@"1 second ago", [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:-1]]);
}

- (void)testSecondsAgo {
    // This is an example of a functional test case.
    
    XCTAssertEqualObjects(@"2 seconds ago", [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:-2]]);
}


- (void)testMinuteAgo {
    // This is an example of a functional test case.
    
    XCTAssertEqualObjects(@"1 minute ago", [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:-61]]);
}

- (void)testMinutesAgo {
    // This is an example of a functional test case.
    
    XCTAssertEqualObjects(@"2 minutes ago", [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:-121]]);
}

- (void)testHourAgo {
    // This is an example of a functional test case.
    
    XCTAssertEqualObjects(@"1 hour ago", [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:-3601]]);
}

- (void)testHoursAgo {
    // This is an example of a functional test case.
    
    XCTAssertEqualObjects(@"2 hours ago", [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:-7201]]);
}

- (void)testDayAgo {
    // This is an example of a functional test case.
    
    XCTAssertEqualObjects(@"1 day ago", [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:-60 * 60 * 24 - 1]]);
}

- (void)testDaysAgo {
    // This is an example of a functional test case.
    
    XCTAssertEqualObjects(@"2 days ago", [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:-60 * 60 * 24 * 2 - 1]]);
}




- (void)testPerformanceDaysAgo {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:-60 * 60 * 24 * 2 - 1]];
    }];
}

- (void)testPerformanceSecondAgo {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:-1]];
    }];
}

- (void)testPerformanceInDays {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:60 * 60 * 24 * 2 + 1]];
    }];
}

- (void)testPerformanceInSecond {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [[SORelativeDateTransformer registeredTransformer] transformedValue:[[NSDate date] dateByAddingTimeInterval:2]];
    }];
}



@end
