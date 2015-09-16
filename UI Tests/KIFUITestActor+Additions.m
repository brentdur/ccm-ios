//
//  KIFUITestActor+Additions.c
//  RUF City Campus
//
//  Created by Brenton Durkee on 9/15/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#include "KIFUITestActor+Additions.h"

@implementation KIFUITestActor (KFAdditions)

-(void) logout {
    NSError *error;
    if ([self tryFindingTappableViewWithAccessibilityLabel:@"Signups" error:&error]){
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        
        [self tapViewWithAccessibilityLabel:@"Signups"];
        [self waitForViewWithAccessibilityLabel:@"Signup Name"];
        for (int i = 0; i < 7; i++){
            CGPoint point = {300, 30};
            [self tapScreenAtPoint:point];
        }
    }
}

-(void) login {
    NSError *error;
    if ([self tryFindingViewWithAccessibilityLabel:@"Welcome Message" error:&error]){
        [self waitForViewWithAccessibilityLabel:@"Welcome Message"];
        [self acknowledgeSystemAlert];
        
        [self enterText:@"admin@brentondurkee.com" intoViewWithAccessibilityLabel:@"Email"];
        [self enterText:@"123" intoViewWithAccessibilityLabel:@"Password"];
        [self tapViewWithAccessibilityLabel:@"LogIn Button"];
        
        [tester waitForTappableViewWithAccessibilityLabel:@"Events"];
    }
}

@end
