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

+(void) sync {
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
    return [self getsForEntity:ENTITY_EVENT];
}

+(NSArray *) getTalks{
    return [self getsForEntity:ENTITY_TALKS];
}

+(NSArray *) getMessages{
    return [self getsForEntity:ENTITY_MESSAGES];
}

+(NSArray *) getGroups{
    return [self getsForEntity:ENTITY_GROUPS];
}

+(NSArray *) getLocations{
    return [self getsForEntity:ENTITY_LOCATIONS];
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
        database = [self getEvents];
    }
    else if ([type isEqualToString:ENTITY_TALKS]) {
        database = [self getTalks];
    }
    else if ([type isEqualToString:ENTITY_MESSAGES]) {
        database = [self getMessages];
    }
    else if ([type isEqualToString:ENTITY_GROUPS]) {
        database = [self getGroups];
    }
    else if ([type isEqualToString:ENTITY_LOCATIONS]) {
        database = [self getLocations];
    }
    NSLog(@"%@", array);
    
    for (id saved in database){
        BOOL found = false;
        for (NSMutableDictionary *item in array){
            if([[saved getIdd] isEqualToString:[item valueForKey:@"_id"]]){
                found = true;
                if([(NSNumber *)[item valueForKey:@"version"] compare:[saved getVersion]] > 0){
                    NSLog(@"update");
                    [saved setDescriptionUsing:item];
                    updates++;
                }
                NSLog(@"remove from array");
                [array removeObject:item];
                break;
            }
        }
        if(!found){
            NSLog(@"delete");
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

@end
