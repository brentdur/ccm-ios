//
//  Messages.h
//  ccm
//
//  Created by Brenton Durkee on 7/29/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DateUtil.h"
#import "Topics.h"


@interface Messages : NSManagedObject

@property (nonatomic, retain) NSString * from;
@property (nonatomic, retain) NSString * simpleFrom;
@property (nonatomic, retain) NSString * to;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSNumber * version;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString *topic;

-(NSString *)getIdd;
-(NSNumber *)getVersion;

-(void)setDescriptionUsing:(NSDictionary *) item;

@end
