//
//  Conversations+CoreDataProperties.h
//  RUF City Campus
//
//  Created by Brenton Durkee on 11/4/15.
//  Copyright © 2015 Brenton Durkee. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Conversations.h"

NS_ASSUME_NONNULL_BEGIN

@interface Conversations (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *from_who;
@property (nullable, nonatomic, retain) NSString *messages;
@property (nullable, nonatomic, retain) NSString *minmessages;
@property (nullable, nonatomic, retain) NSString *participant;
@property (nullable, nonatomic, retain) NSNumber *singleton;
@property (nullable, nonatomic, retain) NSString *subject;
@property (nullable, nonatomic, retain) NSString *topic;
@property (nullable, nonatomic, retain) NSNumber *version;

@end

NS_ASSUME_NONNULL_END
