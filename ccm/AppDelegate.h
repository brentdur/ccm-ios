//
//  AppDelegate.h
//  CoreDataTest
//
//  Created by Brenton Durkee on 7/27/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Google/CloudMessaging.h>
#import "AFNetworking.h"
#import "DataController.h"
#import "GCM.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, GGLInstanceIDDelegate, GCMReceiverDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, readonly, strong) NSString *registrationKey;
@property (nonatomic, readonly, strong) NSString *messageKey;
@property (nonatomic, readonly, strong) NSString *gcmSenderID;
@property (nonatomic, readonly, strong) NSString *registrationOptions;

@property(nonatomic, strong) void (^registrationHandler)
(NSString *registrationToken, NSError *error);
@property(nonatomic, assign) BOOL connectedToGCM;
@property(nonatomic, strong) NSString* registrationToken;
@property(nonatomic, assign) BOOL subscribedToTopic;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end