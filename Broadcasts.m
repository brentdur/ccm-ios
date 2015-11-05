//
//  Broadcasts.m
//  RUF City Campus
//
//  Created by Brenton Durkee on 11/4/15.
//  Copyright © 2015 Brenton Durkee. All rights reserved.
//

#import "Broadcasts.h"
#import "DateUtil.h"

@implementation Broadcasts

-(NSString *) getIdd {
    return [self id];
}

-(NSNumber *) getVersion {
    return [self version];
}

-(void) setIdd:(NSString *) id {
    [self setId:id];
}

-(void) setDescriptionUsing:(NSDictionary *) item {
    [self setDate:[DateUtil dateFromString:[item valueForKey:@"date"]]];
    [self setId:[item valueForKey:@"_id"]];
    [self setMessage:[item valueForKey:@"message"]];
    [self setTitle:[item valueForKey:@"title"]];
    [self setVersion:[item valueForKey:@"version"]];
}

@end
