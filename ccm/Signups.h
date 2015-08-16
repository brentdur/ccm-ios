//
//  Signups.h
//  ccm
//
//  Created by Brenton Durkee on 8/10/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Signups : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * dateInfo;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * version;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * memberCount;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSNumber * memberOf;

-(NSString *) getIdd;
-(NSNumber *) getVersion;

-(void) setDescriptionUsing:(NSDictionary *) item;

@end
