//
//  MessageViewTests.m
//  RUF City Campus
//
//  Created by Brenton Durkee on 9/16/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <XCTest/XCTest.h>
#import <KIF/KIF.h>
#import "KIFUITestActor+Additions.h"

@interface MessageViewTests : KIFTestCase

@end

@implementation MessageViewTests

-(void)beforeAll {
    [tester login];
}

-(void)afterEach {
    NSError *error;
    if ([tester tryFindingViewWithAccessibilityLabel:@"Back" error:&error]){
        [tester tapViewWithAccessibilityLabel:@"Back"];
    }
}

-(void) afterAll {
    [tester logout];
}

-(void) testSendFromEvents {
    [tester tapViewWithAccessibilityLabel:@"Events"];
    
    [tester tapViewWithAccessibilityLabel:@"Compose"];
    
    [tester waitForViewWithAccessibilityLabel:@"Subject"];
}

-(void) testSendFromSignups {
    [tester tapViewWithAccessibilityLabel:@"Signups"];
    
    [tester tapViewWithAccessibilityLabel:@"Compose"];
    
    [tester waitForViewWithAccessibilityLabel:@"Subject"];
}

-(void) testSendFromTalks {
    [tester tapViewWithAccessibilityLabel:@"Talks"];
    
    [tester tapViewWithAccessibilityLabel:@"Compose"];
    
    [tester waitForViewWithAccessibilityLabel:@"Subject"];
}

@end
