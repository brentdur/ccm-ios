//
//  DataController.m
//  ccm
//
//  Created by Brenton Durkee on 7/29/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "DataController.h"
#import "Constaints.h"

@implementation DataController

static id <DataControllerDelegate> delegate;
static NSUInteger numEvents;
static NSUInteger numMsgs;
static NSUInteger numTalks;
static NSUInteger numSignups;

+(void) sync {
    [self rollback];
    NSManagedObjectContext *moc =  [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
    DataRequest *si = [DataRequest sharedInstance];
    [si updateEventsUsingBlock:^(NSMutableArray *data, NSError *error) {
        [self checkItemsFrom:data for:moc entity:ENTITY_EVENT];
    }];
    [si updateMessagesUsingBlock:^(NSMutableArray *data, NSError *error) {
        [self checkItemsFrom:data for:moc entity:ENTITY_MESSAGES];
    }];
    [si updateTalksUsingBlock:^(NSMutableArray *data, NSError *error) {
        [self checkItemsFrom:data for:moc entity:ENTITY_TALKS];
    }];
    [si updateGroupsUsingBlock:^(NSMutableArray *data, NSError *error) {
        [self checkItemsFrom:data for:moc entity:ENTITY_GROUPS];
    }];
    [si updateLocationsUsingBlock:^(NSMutableArray *data, NSError *error) {
        [self checkItemsFrom:data for:moc entity:ENTITY_LOCATIONS];
    }];
    [si updateTopicsUsingBlock:^(NSMutableArray *data, NSError *error) {
        [self checkItemsFrom:data for:moc entity:ENTITY_TOPICS];
    }];
    [si updateSignupsUsingBlock:^(NSMutableArray *data, NSError *error) {
        [self checkItemsFrom:data for:moc entity:ENTITY_SIGNUPS];
    }];
    
}

+(void) rollback{
    NSManagedObjectContext *moc = [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
    [moc rollback];
}

+(void) addEventWithData:(NSDictionary *) data{
    DataRequest *si = [DataRequest sharedInstance];
    [si AFpostWithUrl:URL_POST_EVENTS andData:data returnTo:^(NSMutableArray *data, NSError *error) {
        NSLog(@"returned");
    }];
}

+(void) addMsgWithData:(NSDictionary *) data{
    DataRequest *si = [DataRequest sharedInstance];
    [si AFpostWithUrl:URL_POST_MESSAGES andData:data returnTo:^(NSMutableArray *data, NSError *error) {
        NSLog(@"returned");
    }];
}

+(void) addTalkWithData:(NSDictionary *)data{
    DataRequest *si = [DataRequest sharedInstance];
    [si AFpostWithUrl:URL_POST_TALKS andData:data returnTo:^(NSMutableArray *data, NSError *error) {
        NSLog(@"returned");
    }];
}

+(void) addSignupWithData:(NSDictionary *)data{
    DataRequest *si = [DataRequest sharedInstance];
    [si AFpostWithUrl:URL_POST_SIGNUPS andData:data returnTo:^(NSMutableArray *data, NSError *error) {
        NSLog(@"returned");
    }];
}

+(void) putUserToSignup:(NSDictionary *) data{
    DataRequest *si = [DataRequest sharedInstance];
    [si AFputWithUrl:URL_PUT_SIGNUPS andData:data returnTo:^(NSMutableArray *data, NSError *error) {
        NSLog(@"put!");
    }];
    
}

+(NSArray *) getsForEntity: (NSString *) name{
    NSManagedObjectContext *moc =  [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *ret = [NSEntityDescription entityForName:name inManagedObjectContext:moc];
    [request setEntity:ret];
    NSError *error;
    return [moc executeFetchRequest:request error:&error];
}

+(NSArray *) getEvents{
    NSArray *ret = [self getsForEntity:ENTITY_EVENT];
    return ret;
}

+(NSArray *) getTalks{
    NSArray *ret = [self getsForEntity:ENTITY_TALKS];
    
    return ret;
}

+(NSArray *) getMessages{
    NSArray *ret = [self getsForEntity:ENTITY_MESSAGES];
    
    return ret;
}

+(NSArray *) getGroups{
    return [self getsForEntity:ENTITY_GROUPS];
}

+(NSArray *) getLocations{
    return [self getsForEntity:ENTITY_LOCATIONS];
}

+(NSArray *) getTopics{
    return [self getsForEntity:ENTITY_TOPICS];
}

+(NSArray *) getSignups{
    return [self getsForEntity:ENTITY_SIGNUPS];
}

+(void) setDelegate:(id) del{
    delegate = del;
}

+(void) checkItemsFrom:(NSMutableArray *) array for:(NSManagedObjectContext *) context entity:(NSString *)type{
    int updates = 0;
    int deletes = 0;
    int creates = 0;
    NSArray *database;
    if ([type isEqualToString:ENTITY_EVENT]) {
        numEvents = [array count];
        database = [self getEvents];
    }
    else if ([type isEqualToString:ENTITY_TALKS]) {
        numTalks = [array count];
        database = [self getTalks];
    }
    else if ([type isEqualToString:ENTITY_MESSAGES]) {
        numMsgs = [array count];
        database = [self getMessages];
    }
    else if ([type isEqualToString:ENTITY_GROUPS]) {
        database = [self getGroups];
    }
    else if ([type isEqualToString:ENTITY_LOCATIONS]) {
        database = [self getLocations];
    }
    else if ([type isEqualToString:ENTITY_TOPICS]) {
        database = [self getTopics];
    }
    else if ([type isEqualToString:ENTITY_SIGNUPS]){
        numSignups = [array count];
        database = [self getSignups];
    }
    NSLog(@"Array Count: %lu", [array count]);
    
    for (id saved in database){
        BOOL found = false;
        for (NSMutableDictionary *item in array){
            if([[saved getIdd] isEqualToString:[item valueForKey:@"_id"]]){
                found = true;
                if([(NSNumber *)[item valueForKey:@"version"] compare:[saved getVersion]] > 0){
                    [saved setDescriptionUsing:item];
                    updates++;
                }
                [array removeObject:item];
                break;
            }
        }
        if(!found){
            [context deleteObject:saved];
            deletes++;
        }
    }
    for (NSDictionary *item in array){
        id event = [NSEntityDescription insertNewObjectForEntityForName:type inManagedObjectContext:context];
        [event setDescriptionUsing:item];
        creates++;
    }
    NSLog(@"Creates: %d, Deletes: %d, Updates: %d", creates, deletes, updates);
    if(delegate){
        [delegate didUpdateData];
        delegate = nil;
    }
    [context save:nil];
}

+(NSUInteger) getNumEvents{
    return numEvents;
}

+(NSUInteger) getNumMsgs{
    return numMsgs;
}

+(NSUInteger) getNumTalks{
    return numTalks;
}

+(NSUInteger) getNumSignups{
    return numSignups;
}

@end
