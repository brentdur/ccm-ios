//
//  StarterViewController.m
//  ccm
//
//  Created by Brenton Durkee on 7/28/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "StarterViewController.h"
#import "Constaints.h"

@implementation StarterViewController
-(void)viewDidAppear:(BOOL)animated {

    BOOL hasToken = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_HAS_TOKEN];
    UIViewController *cont;
    if (hasToken) {
        cont = [self.storyboard instantiateViewControllerWithIdentifier:@"RVC"];
        [DataController sync];
    }
    else {
        cont = [self.storyboard instantiateViewControllerWithIdentifier:@"AuthNav"];
    }
    [self presentViewController:cont animated:false completion:nil];
    [self removeFromParentViewController];
}
@end
