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
+(void) rollback;

+(void) addEventWithData:(NSDictionary *) data;
+(void) addMsgWithData:(NSDictionary *) data;
+(void) addTalkWithData:(NSDictionary *) data;
+(void) addSignupWithData:(NSDictionary *) data;

+(void) putUserToSignup:(NSDictionary *) data;

+(void) saveMyGroup;

# pragma mark - Get methods
+(NSArray *) getEvents;
+(NSArray *) getTalks;
+(NSArray *) getMessages;
+(NSArray *) getGroups;
+(NSArray *) getLocations;
+(NSArray *) getTopics;
+(NSArray *) getSignups;

+(void) deleteEvents;

+(void) setDelegate:(id) del withType:(NSString *) type;



+(NSUInteger) getNumEvents;
+(NSUInteger) getNumMsgs;
+(NSUInteger) getNumTalks;
+(NSUInteger) getNumSignups;


@end

@protocol DataControllerDelegate
@optional
-(void) didUpdateData;

@end
