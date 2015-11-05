//
//  Broadcasts+CoreDataProperties.h
//  RUF City Campus
//
//  Created by Brenton Durkee on 11/4/15.
//  Copyright © 2015 Brenton Durkee. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Broadcasts.h"

NS_ASSUME_NONNULL_BEGIN

@interface Broadcasts (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *message;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *version;

@end

NS_ASSUME_NONNULL_END
