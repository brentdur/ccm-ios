//
//  Groups.h
//  ccm
//
//  Created by Brenton Durkee on 7/29/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Groups : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * write_talks;
@property (nonatomic, retain) NSNumber * write_events;
@property (nonatomic, retain) NSNumber * write_msgs;
@property (nonatomic, retain) NSNumber * version;
@property (nonatomic, retain) NSString * id;

-(NSString *)getIdd;
-(NSNumber *)getVersion;

-(void)setDescriptionUsing:(NSDictionary *) item;

@end
