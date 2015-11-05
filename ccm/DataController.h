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
#import "Conversations.h"
#import "Broadcasts.h"
#import "Talks.h"
#import "Groups.h"
#import "Locations.h"



@interface DataController : NSObject

+(void) sync;
+(void) rollback;
+(void) syncSelective:(NSString *) ent;

+(void) addEventWithData:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;
+(void) addTalkWithData:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;
+(void) addSignupWithData:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;
+(void) addBroadcastWithData:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;
+(void) addSyncCastWithData:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;
+(void) addConvoWithData:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;

+(void) postGcmToUser:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;

+(void) putUserToSignup:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;
+(void) putMsgToConvo:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;
+(void) putKillConvo:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;
+(void) putKillBC:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;

+(void) saveMyGroup;
+(void) testGCMToken: (NSString *) token;

+(void) signIn:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;
+(void) signUp:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler;

# pragma mark - Get methods
+(NSArray *) getEvents;
+(NSArray *) getTalks;
+(NSArray *) getGroups;
+(NSArray *) getLocations;
+(NSArray *) getTopics;
+(NSArray *) getSignups;
+(NSArray *) getBroadcasts;
+(NSArray *) getConvos;

+(void) setDelegate:(id) del withType:(NSString *) type;
+(void) setGroupDelegate:(id) del;



+(NSUInteger) getNumEvents;
+(NSUInteger) getNumTalks;
+(NSUInteger) getNumSignups;
+(NSUInteger) getNumBroadcasts;
+(NSUInteger) getNumConvos;


@end

@protocol DataControllerDelegate
@optional
-(void) didUpdateData;

@end

@protocol DataControllerGroupsDelegate
@optional
-(void) didUpdateData;

@end
