//
//  Topics.h
//  ccm
//
//  Created by Brenton Durkee on 8/10/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Topics : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * isAnon;
@property (nonatomic, retain) NSNumber * version;

-(NSString *) getIdd;
-(NSNumber *) getVersion;

-(void) setIdd:(NSString *) id;

-(void) setDescriptionUsing:(NSDictionary *) item;

@end
