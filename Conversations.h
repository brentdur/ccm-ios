//
//  Conversations.h
//  RUF City Campus
//
//  Created by Brenton Durkee on 11/4/15.
//  Copyright © 2015 Brenton Durkee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Conversations : NSManagedObject

-(NSString *) getIdd;
-(NSNumber *) getVersion;

-(void) setIdd:(NSString *) id;

-(void) setDescriptionUsing:(NSDictionary *) item;

@end

NS_ASSUME_NONNULL_END

#import "Conversations+CoreDataProperties.h"
