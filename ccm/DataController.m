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
static id <DataControllerGroupsDelegate> groupDelegate;
static NSString *delegateType;
static NSUInteger numEvents;
static NSUInteger numMsgs;
static NSUInteger numTalks;
static NSUInteger numSignups;

+(void) sync {
    [self rollback];
    NSManagedObjectContext *moc =  [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
    DataRequest *si = [DataRequest sharedInstance];
    [self syncEventsFor:moc Using:si];
    [self syncMessagesFor:moc Using:si];
    [self syncTalksFor:moc Using:si];
    [self syncGroupsFor:moc Using:si];
    [self syncLocationsFor:moc Using:si];
    [self syncTopicsFor:moc Using:si];
    [self syncSignupsFor:moc Using:si];
    
}

+(void) syncSelective:(NSString *) ent {
    [self rollback];
    NSManagedObjectContext *moc =  [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
    DataRequest *si = [DataRequest sharedInstance];
    if ([ent isEqualToString:@"events"]){
        [self syncEventsFor:moc Using:si];
    }
    else if ([ent isEqualToString:@"messages"]){
        [self syncMessagesFor:moc Using:si];
    }
    else if ([ent isEqualToString:@"talks"]){
        [self syncTalksFor:moc Using:si];
    }
    else if ([ent isEqualToString:@"groups"]){
        [self syncGroupsFor:moc Using:si];
    }
    else if ([ent isEqualToString:@"locations"]){
        [self syncLocationsFor:moc Using:si];
    }
    else if ([ent isEqualToString:@"topics"]){
        [self syncTopicsFor:moc Using:si];
    }
    else if ([ent isEqualToString:@"signups"]){
        [self syncSignupsFor:moc Using:si];
    }
    else if ([ent isEqualToString:@"all"]) {
        [self sync];
    }
}

+(void) syncEventsFor: (NSManagedObjectContext *)moc Using:(DataRequest *)si {
    [si updateEventsUsingBlock:^(NSMutableArray *data, NSError *error) {
        [self checkItemsFrom:data for:moc entity:ENTITY_EVENT];
    }];
}

+(void) syncMessagesFor: (NSManagedObjectContext *)moc Using:(DataRequest *)si {
    [si updateMessagesUsingBlock:^(NSMutableArray *data, NSError *error) {
        [self checkItemsFrom:data for:moc entity:ENTITY_MESSAGES];
    }];
}

+(void) syncTalksFor: (NSManagedObjectContext *)moc Using:(DataRequest *)si {
    [si updateTalksUsingBlock:^(NSMutableArray *data, NSError *error) {
        [self checkItemsFrom:data for:moc entity:ENTITY_TALKS];
    }];
}

+(void) syncGroupsFor: (NSManagedObjectContext *)moc Using:(DataRequest *)si {
    [si updateGroupsUsingBlock:^(NSMutableArray *data, NSError *error) {
        [self checkItemsFrom:data for:moc entity:ENTITY_GROUPS];
    }];
}

+(void) syncLocationsFor: (NSManagedObjectContext *)moc Using:(DataRequest *)si {
    [si updateLocationsUsingBlock:^(NSMutableArray *data, NSError *error) {
        [self checkItemsFrom:data for:moc entity:ENTITY_LOCATIONS];
    }];
}

+(void) syncTopicsFor: (NSManagedObjectContext *)moc Using:(DataRequest *)si {
    [si updateTopicsUsingBlock:^(NSMutableArray *data, NSError *error) {
        [self checkItemsFrom:data for:moc entity:ENTITY_TOPICS];
    }];
}

+(void) syncSignupsFor: (NSManagedObjectContext *)moc Using:(DataRequest *)si {
    [si updateSignupsUsingBlock:^(NSMutableArray *data, NSError *error) {
        [self checkItemsFrom:data for:moc entity:ENTITY_SIGNUPS];
    }];
}

+(void) saveMyGroup{
    DataRequest *si = [DataRequest sharedInstance];
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    [si getMyInfo:^(NSMutableArray *data, NSError *error) {
        for (NSDictionary *group in [data valueForKey:@"groups"]){
            NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
            [info setValue:[group valueForKey:@"name"] forKey:@"name"];
            [info setValue:[group valueForKey:@"writeSignups"] forKey:@"writeSignups"];
            [info setValue:[group valueForKey:@"writeEvents"] forKey:@"writeEvents"];
            [info setValue:[group valueForKey:@"writeTalks"] forKey:@"writeTalks"];
            [ret addObject:info];
        }
        [[NSUserDefaults standardUserDefaults] setValue:ret forKey:KEY_GROUPS];
        [groupDelegate didUpdateData];
        groupDelegate = nil;
    }];
    
}

+(void) rollback{
    NSManagedObjectContext *moc = [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
    [moc rollback];
}

+(void) addEventWithData:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler{
    DataRequest *si = [DataRequest sharedInstance];
    [si AFpostWithUrl:URL_POST_EVENTS andData:data returnTo:handler];
}

+(void) addMsgWithData:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler{
    DataRequest *si = [DataRequest sharedInstance];
    [si AFpostWithUrl:URL_POST_MESSAGES andData:data returnTo:handler];
}

+(void) addTalkWithData:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler {
    DataRequest *si = [DataRequest sharedInstance];
    [si AFpostWithUrl:URL_POST_TALKS andData:data returnTo:handler];
}

+(void) addSignupWithData:(NSDictionary *)data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler{
    DataRequest *si = [DataRequest sharedInstance];
    [si AFpostWithUrl:URL_POST_SIGNUPS andData:data returnTo:handler];
}

+(void) postGcmToUser:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler{
    DataRequest *si = [DataRequest sharedInstance];
    [si AFpostWithUrl:URL_POST_GCM andData:data returnTo:handler];
    
}

+(void) putUserToSignup:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler{
    DataRequest *si = [DataRequest sharedInstance];
    [si AFputWithUrl:URL_PUT_SIGNUPS andData:data returnTo:handler];
    
}

+(void) deleteMsg:(NSDictionary *)data andHandler:(void (^)(NSMutableArray *, NSError *))handler {
    DataRequest *si = [DataRequest sharedInstance];
    [si AFdeleteWithUrl:URL_DELETE_MSG andData:data returnTo:handler];
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
    NSLog(@"got events");
    ret = [ret sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Events *a = (Events *) obj1;
        Events *b = (Events *) obj2;
        return [[a date] compare:[b date]];
        
    }];

    return ret;
}

+(NSArray *) getTalks{
    NSArray *ret = [self getsForEntity:ENTITY_TALKS];
    NSLog(@"got talks");
    ret = [ret sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Talks *a = (Talks *) obj1;
        Talks *b = (Talks *) obj2;
        return [[b date] compare:[a date]];
        
    }];
    return ret;
}

+(NSArray *) getMessages{
    NSArray *ret = [self getsForEntity:ENTITY_MESSAGES];
    NSLog(@"got messages");
    ret = [ret sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Messages *a = (Messages *) obj1;
        Messages *b = (Messages *) obj2;
        return [[b date] compare:[a date]];
        
    }];
    return ret;
}

+(NSArray *) getGroups{
    NSLog(@"got groups");
    return [self getsForEntity:ENTITY_GROUPS];
}

+(NSArray *) getLocations{
    NSLog(@"got locs");
    return [self getsForEntity:ENTITY_LOCATIONS];
}

+(NSArray *) getTopics{
    NSLog(@"got topics");
    return [self getsForEntity:ENTITY_TOPICS];
}

+(NSArray *) getSignups{
    NSLog(@"got signups");
    return [self getsForEntity:ENTITY_SIGNUPS];
}

+(void) setDelegate:(id) del withType:(NSString *)type{
    delegate = del;
    delegateType = type;
}

+(void) setGroupDelegate:(id) del {
    groupDelegate = del;
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
    if(delegate && [type isEqualToString:delegateType]){
        [delegate didUpdateData];
        delegate = nil;
        delegateType = nil;
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

+(void) signIn:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler{
    DataRequest *si = [DataRequest sharedInstance];
    [si AFauthPostWithUrl:URL_POST_SIGNIN andData:data returnTo:handler];
}

+(void) signUp:(NSDictionary *) data andHandler:(void (^)(NSMutableArray *data, NSError *error)) handler{
    DataRequest *si = [DataRequest sharedInstance];
    [si AFauthPostWithUrl:URL_POST_SIGNUP andData:data returnTo:handler];
}

@end
