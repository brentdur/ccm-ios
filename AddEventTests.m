//
//  AddEventTests.m
//  RUF City Campus
//
//  Created by Brenton Durkee on 9/17/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <KIF/KIF.h>
#import "KIFUITestActor+Additions.h"

@interface AddEventTests : KIFTestCase

@end

@implementation AddEventTests

-(void) beforeAll {
    [tester login];
}

-(void) afterAll {
    [tester logout];
}

-(void) testAddEvent {
    [tester tapViewWithAccessibilityLabel:@"Events"];
    [tester tapViewWithAccessibilityLabel:@"Add"];
    [tester waitForViewWithAccessibilityLabel:@"Title"];
    
    [tester clearTextFromAndThenEnterText:@"New event test title" intoViewWithAccessibilityLabel:@"Title"];
    [tester clearTextFromAndThenEnterText:@"19:30 06/14/16" intoViewWithAccessibilityLabel:@"Date"];
    [tester clearTextFromAndThenEnterText:@"This is the test event description" intoViewWithAccessibilityLabel:@"Description"];

    [tester selectPickerViewRowWithTitle:@"Redeemer UWS"];
    [tester waitForViewWithAccessibilityLabel:@"Locations" value:@"Redeemer UWS" traits:UIAccessibilityTraitNone];
    
    [tester tapViewWithAccessibilityLabel:@"Done"];
    [tester waitForViewWithAccessibilityLabel:@"Events"];

    
}

@end
