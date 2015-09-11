//
//  GCM.h
//  RUF City Campus
//
//  Created by Brenton Durkee on 9/2/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Google/CloudMessaging.h>
#import "DataController.h"
#import "AppDelegate.h"
#import "Constaints.h"

@interface GCM : NSObject

+(void)doStuff;
+(void)tokenHandle:(NSString *)registrationToken andError:(NSError *) error;

@end
