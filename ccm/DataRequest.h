//
//  DataRequests.h
//  ccm
//
//  Created by Brenton Durkee on 7/29/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeychainItemWrapper.h"
#import "AFNetworking.h"

@protocol DataRequestDelegate;

@interface DataRequest : NSObject <NSURLSessionDataDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate>

@property id<DataRequestDelegate> delegate;
@property NSMutableData *response;
@property NSMutableDictionary *data;

+(DataRequest *) sharedInstance;

-(void) updateEventsWithDelegate:(id)delegate;
-(void) updateMessagesWithDelegate:(id)delegate;
-(void) updateTalksWithDelegate:(id)delegate;
-(void) updateGroupsWithDelegate:(id)delegate;
-(void) updateLocationsWithDelegate:(id)delegate;

-(void) updateEventsUsingBlock:(void (^)(NSMutableArray * data, NSError * error)) handler;
-(void) updateMessagesUsingBlock:(void (^)(NSMutableArray * data, NSError * error)) handler;
-(void) updateTalksUsingBlock:(void (^)(NSMutableArray * data, NSError * error)) handler;
-(void) updateGroupsUsingBlock:(void (^)(NSMutableArray * data, NSError * error)) handler;
-(void) updateLocationsUsingBlock:(void (^)(NSMutableArray * data, NSError * error)) handler;

-(void) AFrequestWithURl:(NSString *) urlString returnTo:(void (^)(NSMutableArray * data, NSError * error)) handler;


@end

@protocol DataRequestDelegate

-(void) dataRequest:(DataRequest *)dataRequest didReturnData:(id)data forType:(NSString *) type;
@optional

@end

