//
//  GCM.m
//  RUF City Campus
//
//  Created by Brenton Durkee on 9/2/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "GCM.h"

@implementation GCM

+(void)doStuff{
    AppDelegate *appDel = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSString *token = [appDel registrationToken];
    NSLog(@"Token: %@", token);
}

+(void)tokenHandle:(NSString *)registrationToken andError:(NSError *) error{
    if (registrationToken != nil){
        NSLog(@"Reg Token: %@", registrationToken);

        if (![[[NSUserDefaults standardUserDefaults] stringForKey:KEY_GCM_TOKEN] isEqualToString:registrationToken]){
            [[NSUserDefaults standardUserDefaults] setBool:false forKey:KEY_GCM_SUBMITTED];
            [[NSUserDefaults standardUserDefaults] setObject:registrationToken forKey:KEY_GCM_TOKEN];
        }
        if (![[NSUserDefaults standardUserDefaults] boolForKey:KEY_GCM_SUBMITTED]){
            NSDictionary *dic = @{@"gcm": registrationToken};
            [DataController postGcmToUser:dic andHandler:^(NSMutableArray *retData, NSError *error) {
                if(error != nil){
                    NSLog(@"problem adding to server");
                }
                else {
                    NSLog(@"added to server");
                    [[NSUserDefaults standardUserDefaults] setBool:true forKey:KEY_GCM_SUBMITTED];
                }
            }];
        }
        [DataController testGCMToken:registrationToken];
    }
    else {
        NSLog(@"Reg to GCM Failed with error: %@", error.localizedDescription);
        
    }
}

@end
