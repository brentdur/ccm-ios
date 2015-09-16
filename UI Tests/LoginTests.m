//
//  LoginTests.m
//  RUF City Campus
//
//  Created by Brenton Durkee on 9/14/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <XCTest/XCTest.h>
#import <KIF/KIF.h>
#import "KIFUITestActor+Additions.h"


@interface LoginTests : KIFTestCase
@end

@implementation LoginTests

-(void) beforeAll
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}


-(void) afterEach
{
    [tester logout];
}

-(void)testSuccessfulLogin {
    
    [tester waitForViewWithAccessibilityLabel:@"Welcome Message"];
    [tester acknowledgeSystemAlert];
    
    [tester clearTextFromAndThenEnterText:@"admin@brentondurkee.com" intoViewWithAccessibilityLabel:@"Email"];
    [tester clearTextFromAndThenEnterText:@"123" intoViewWithAccessibilityLabel:@"Password"];
    [tester tapViewWithAccessibilityLabel:@"LogIn Button"];
    
    [tester waitForTappableViewWithAccessibilityLabel:@"Events"];
}

-(void) testBetweenSignupSignin {
    [tester waitForViewWithAccessibilityLabel:@"Welcome Message"];
    [tester acknowledgeSystemAlert];
    
    [tester tapViewWithAccessibilityLabel:@"Need An Account"];
    [tester waitForViewWithAccessibilityLabel:@"Sign Up"];
    [tester tapViewWithAccessibilityLabel:@"Back"];
    [tester waitForViewWithAccessibilityLabel:@"Welcome Message"];
}

-(void) testNoEmail {
    [tester waitForViewWithAccessibilityLabel:@"Welcome Message"];
    [tester acknowledgeSystemAlert];
    
    [tester clearTextFromAndThenEnterText:@"" intoViewWithAccessibilityLabel:@"Email"];
    [tester clearTextFromAndThenEnterText:@"123" intoViewWithAccessibilityLabel:@"Password"];
    [tester tapViewWithAccessibilityLabel:@"LogIn Button"];
    
    NSError *error;
    BOOL test = [tester tryFindingViewWithAccessibilityLabel:@"Signups" error:&error];
    XCTAssert(!test);
}

-(void) testNoPass {
    [tester waitForViewWithAccessibilityLabel:@"Welcome Message"];
    [tester acknowledgeSystemAlert];
    
    [tester clearTextFromAndThenEnterText:@"admin@brentondurkee.com" intoViewWithAccessibilityLabel:@"Email"];
    [tester clearTextFromAndThenEnterText:@"" intoViewWithAccessibilityLabel:@"Password"];
    [tester tapViewWithAccessibilityLabel:@"LogIn Button"];
    
    NSError *error;
    BOOL test = [tester tryFindingViewWithAccessibilityLabel:@"Signups" error:&error];
    XCTAssert(!test);
}



@end
