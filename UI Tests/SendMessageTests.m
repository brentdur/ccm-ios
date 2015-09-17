//
//  SendMessageTests.m
//  RUF City Campus
//
//  Created by Brenton Durkee on 9/15/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <XCTest/XCTest.h>
#import <KIF/KIF.h>
#import "KIFUITestActor+Additions.h"

@interface SendMessageTests : KIFTestCase

@end

@implementation SendMessageTests

-(void)beforeAll{
    [tester login];
    [tester waitForViewWithAccessibilityLabel:@"Compose"];
    [tester tapViewWithAccessibilityLabel:@"Compose"];
    [tester waitForViewWithAccessibilityLabel:@"Subject"];
}

-(void)beforeEach{
    NSError *error;
    if ([tester tryFindingViewWithAccessibilityLabel:@"Compose" error:&error]){
        [tester tapViewWithAccessibilityLabel:@"Compose"];
    }
}

-(void)afterAll{
    [tester logout];
}

-(void) testSendMessage{
    [tester clearTextFromAndThenEnterText:@"Random Question" intoViewWithAccessibilityLabel:@"Subject"];
    [tester selectPickerViewRowWithTitle:@"More information"];
    
    [tester waitForViewWithAccessibilityLabel:@"Topics" value:@"More information" traits:UIAccessibilityTraitNone];
    
    [tester clearTextFromAndThenEnterText:@"This is the question message text" intoViewWithAccessibilityLabel:@"Message"];
    
    [tester tapViewWithAccessibilityLabel:@"Send"];
    [tester waitForViewWithAccessibilityLabel:@"Signups"];
    
}

-(void) testSendEmptyMessage{
    [tester tapViewWithAccessibilityLabel:@"Send"];
    
    [tester waitForAnimationsToFinish];
    NSLog(@"animations done");
    NSError *error;
    BOOL test = [tester tryFindingViewWithAccessibilityLabel:@"Signups" error:&error];
    XCTAssert(!test);
}

-(void) testSendEmptySubject{
    [tester clearTextFromAndThenEnterText:@"" intoViewWithAccessibilityLabel:@"Subject"];
    [tester selectPickerViewRowWithTitle:@"Question"];
    [tester clearTextFromAndThenEnterText:@"This is the question message text" intoViewWithAccessibilityLabel:@"Message"];
    [tester tapViewWithAccessibilityLabel:@"Send"];
    
    [tester waitForAnimationsToFinish];
    NSLog(@"animations done");
    NSError *error;
    BOOL test = [tester tryFindingViewWithAccessibilityLabel:@"Signups" error:&error];
    XCTAssert(!test);
}



@end
