//
//  DataController.h
//  ccm
//
//  Created by Brenton Durkee on 7/29/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataRequest.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Events.h"
#import "Messages.h"
#import "Talks.h"
#import "Groups.h"
#import "Locations.h"



@interface DataController : NSObject <DataRequestDelegate>

+(void) sync;


# pragma mark - Get methods
+(NSArray *) getEvents;
+(NSArray *) getTalks;
+(NSArray *) getMessages;
+(NSArray *) getGroups;
+(NSArray *) getLocations;

+(void) deleteEvents;


@end
