//
//  Events.h
//  ccm
//
//  Created by Brenton Durkee on 7/29/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DateUtil.h"


@interface Events : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lng;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * version;
@property (nonatomic, retain) NSString * id;


-(NSString *)getIdd;
-(NSNumber *)getVersion;

-(void)setDescriptionUsing:(NSDictionary *) item;

+(BOOL)updated;
+(void)setUp:(BOOL)value;


@end
