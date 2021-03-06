//
//  Messages.m
//  ccm
//
//  Created by Brenton Durkee on 7/29/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "Messages.h"


@implementation Messages

@dynamic from;
@dynamic simpleFrom;
@dynamic to;
@dynamic subject;
@dynamic date;
@dynamic message;
@dynamic version;
@dynamic id;
@dynamic topic;

-(NSString *)getIdd{
    return self.id;
}
-(NSNumber *)getVersion{
    return self.version;
}

-(void)setDescriptionUsing:(NSDictionary *) item{
    self.id = [item valueForKey:@"_id"];
    self.from = [item valueForKey:@"from"];
    self.simpleFrom = [item valueForKey:@"simpleFrom"];
    self.to = [item valueForKey:@"simpleTo"];
    self.subject = [item valueForKey:@"subject"];
    self.date = [DateUtil dateFromString:[item valueForKey:@"date"]];
    self.message = [item valueForKey:@"message"];
    self.version = [item valueForKey:@"version"];
    NSDictionary *top = [item valueForKey:@"topic"];
    self.topic = [top valueForKey:@"_id"];
}

@end
