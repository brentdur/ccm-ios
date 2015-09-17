//
//  DetailViewTests.m
//  RUF City Campus
//
//  Created by Brenton Durkee on 9/16/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <XCTest/XCTest.h>
#import <KIF/KIF.h>
#import "KIFUITestActor+Additions.h"

@interface DetailViewTests : KIFTestCase

@end

@implementation DetailViewTests

-(void)beforeAll {
    [tester login];
}

-(void) afterEach {
    NSError *error;
    if ([tester tryFindingViewWithAccessibilityLabel:@"Back" error:&error]){
        [tester tapViewWithAccessibilityLabel:@"Back"];
    }
}

-(void) afterAll{
    [tester logout];
}

-(void) testEventsDetail {
    [tester tapViewWithAccessibilityLabel:@"Events"];
    [tester tapRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] inTableViewWithAccessibilityIdentifier:@"Events List"];
    [tester waitForViewWithAccessibilityLabel:@"Time"];
}

-(void) testTalksDetail {
    [tester tapViewWithAccessibilityLabel:@"Talks"];
    [tester tapRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] inTableViewWithAccessibilityIdentifier:@"Talks List"];
    [tester waitForViewWithAccessibilityLabel:@"Author"];
}

-(void) testSignupsDetail {
    [tester tapViewWithAccessibilityLabel:@"Signups"];
    [tester tapRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] inTableViewWithAccessibilityIdentifier:@"Signups List"];
    [tester waitForViewWithAccessibilityLabel:@"Date"];
}


@end
