//
//  DateUtilsTest.m
//  RUF City Campus
//
//  Created by Brenton Durkee on 9/14/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "DateUtil.h"

@interface DateUtilsTest : XCTestCase

@property (nonatomic) NSDate *testDate;
@property (nonatomic) NSDate *tilDate;
@property (nonatomic) NSDate *tenMinsFuture;
@property (nonatomic) NSDate *sixtyDaysFuture;
@property (nonatomic) NSDate *tenDaysFuture;
@property (nonatomic) NSString *dateString;
@property (nonatomic) NSString *dateTilString;
@property (nonatomic) NSString *littleDateString;
@property (nonatomic) NSString *sixtyDays;
@property (nonatomic) NSString *tenDays;
@property (nonatomic) NSString *notADay;

@end

@implementation DateUtilsTest


- (void)setUp {
    [super setUp];
    self.testDate = [[NSDate alloc] initWithTimeIntervalSince1970:0.0];
    self.tilDate = [[NSDate alloc] initWithTimeIntervalSince1970:93784.0];
    self.sixtyDaysFuture = [[NSDate alloc] initWithTimeIntervalSince1970:5184000.0];
    self.tenDaysFuture = [[NSDate alloc] initWithTimeIntervalSince1970:864000.0];
    self.tenMinsFuture = [[NSDate alloc] initWithTimeIntervalSince1970:600.0];
    
    self.littleDateString = @"01/01";
    self.dateTilString = @"starts in 1 days 02:03:04";
    self.sixtyDays = @"on 01/01";
    self.tenDays = @"10 days ago";
    self.notADay = @"<1 day ago";
    
    NSLog(@"%@", [[self testDate] description]);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLittleString {
    [DateUtil eventLittleString:self.testDate];
    XCTAssert(YES, @"Pass");
}


@end
