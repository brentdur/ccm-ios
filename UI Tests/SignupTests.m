//
//  SignupTests.m
//  RUF City Campus
//
//  Created by Brenton Durkee on 9/15/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <KIF/KIF.h>
#import "KIFUITestActor+Additions.h"

@interface SignupTests : KIFTestCase

@end

@implementation SignupTests

-(void) beforeAll
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

-(void) beforeEach {
    NSError *error;
    if ([tester tryFindingViewWithAccessibilityLabel:@"Welcome Message" error:&error]){
        [tester waitForViewWithAccessibilityLabel:@"Welcome Message"];
        [tester acknowledgeSystemAlert];
        [tester tapViewWithAccessibilityLabel:@"Need An Account"];
        [tester waitForTappableViewWithAccessibilityLabel:@"Sign Up"];
    }
}


-(void) afterEach
{
    [tester logout];
}

-(void) afterAll {
    NSError *error;
    if (![tester tryFindingViewWithAccessibilityLabel:@"Welcome Message" error:&error]){
        if ([tester tryFindingViewWithAccessibilityLabel:@"Sign Up" error:&error]) {
            [tester tapViewWithAccessibilityLabel:@"Back"];
        }
    }
}

-(void)testSuccessfulSignup {
    NSString *name = [NSString stringWithFormat:@"test%@", [[NSDate date] description]];
    NSString *email = [NSString stringWithFormat:@"test%@@brentondurkee.com", [[NSDate date] description]];
    [tester clearTextFromAndThenEnterText:name intoViewWithAccessibilityLabel:@"Name"];
    [tester clearTextFromAndThenEnterText:email intoViewWithAccessibilityLabel:@"Email"];
    [tester clearTextFromAndThenEnterText:@"123" intoViewWithAccessibilityLabel:@"Password"];
    
    [tester tapViewWithAccessibilityLabel:@"Sign Up Button"];
    
    [tester waitForTappableViewWithAccessibilityLabel:@"Events"];
}

-(void) testRegisterNoName {
    NSError *error;
    NSString *email = [NSString stringWithFormat:@"test%@@brentondurkee.com", [[NSDate date] description]];
    
    [tester clearTextFromAndThenEnterText:@"" intoViewWithAccessibilityLabel:@"Name"];
    [tester clearTextFromAndThenEnterText:email intoViewWithAccessibilityLabel:@"Email"];
    [tester clearTextFromAndThenEnterText:@"123" intoViewWithAccessibilityLabel:@"Password"];
    
    [tester tapViewWithAccessibilityLabel:@"Sign Up Button"];
    
    BOOL test = [tester tryFindingViewWithAccessibilityLabel:@"Signups" error:&error];
    XCTAssert(!test);
}

-(void) testRegisterNoEmail {
    NSError *error;

    NSString *name = [NSString stringWithFormat:@"test%@", [[NSDate date] description]];
    
    [tester clearTextFromAndThenEnterText:name intoViewWithAccessibilityLabel:@"Name"];
    [tester clearTextFromAndThenEnterText:@"" intoViewWithAccessibilityLabel:@"Email"];
    [tester clearTextFromAndThenEnterText:@"123" intoViewWithAccessibilityLabel:@"Password"];
    
    [tester tapViewWithAccessibilityLabel:@"Sign Up Button"];
    
    BOOL test = [tester tryFindingViewWithAccessibilityLabel:@"Signups" error:&error];
    XCTAssert(!test);
}

-(void) testRegisterNoPass {
    NSError *error;
    
    NSString *name = [NSString stringWithFormat:@"test%@", [[NSDate date] description]];
    NSString *email = [NSString stringWithFormat:@"test%@@brentondurkee.com", [[NSDate date] description]];
    
    [tester clearTextFromAndThenEnterText:name intoViewWithAccessibilityLabel:@"Name"];
    [tester clearTextFromAndThenEnterText:email intoViewWithAccessibilityLabel:@"Email"];
    [tester clearTextFromAndThenEnterText:@"" intoViewWithAccessibilityLabel:@"Password"];
    
    [tester tapViewWithAccessibilityLabel:@"Sign Up Button"];
    
    BOOL test = [tester tryFindingViewWithAccessibilityLabel:@"Signups" error:&error];
    XCTAssert(!test);
}


@end
