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



@interface DataController : NSObject

+(void) sync;
+(void) rollback;
+(void) syncSelective:(NSString *) ent;

+(void) addEventWithData:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;
+(void) addMsgWithData:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;
+(void) addTalkWithData:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;
+(void) addSignupWithData:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;

+(void) postGcmToUser:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;

+(void) putUserToSignup:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;

+(void) deleteMsg:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;

+(void) saveMyGroup;

+(void) signIn:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;
+(void) signUp:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;

# pragma mark - Get methods
+(NSArray *) getEvents;
+(NSArray *) getTalks;
+(NSArray *) getMessages;
+(NSArray *) getGroups;
+(NSArray *) getLocations;
+(NSArray *) getTopics;
+(NSArray *) getSignups;

+(void) setDelegate:(id) del withType:(NSString *) type;
+(void) setGroupDelegate:(id) del;



+(NSUInteger) getNumEvents;
+(NSUInteger) getNumMsgs;
+(NSUInteger) getNumTalks;
+(NSUInteger) getNumSignups;


@end

@protocol DataControllerDelegate
@optional
-(void) didUpdateData;

@end

@protocol DataControllerGroupsDelegate
@optional
-(void) didUpdateData;

@end
