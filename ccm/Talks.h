//
//  Talks.h
//  ccm
//
//  Created by Brenton Durkee on 7/29/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DateUtil.h"


@interface Talks : NSManagedObject

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSString * reference;
@property (nonatomic, retain) NSNumber * version;
@property (nonatomic, retain) NSString * outline;
@property (nonatomic, retain) NSString * fullVerse;
@property (nonatomic, retain) NSString * id;

-(NSString *)getIdd;
-(NSNumber *)getVersion;

-(void)setDescriptionUsing:(NSDictionary *) item;

@end
