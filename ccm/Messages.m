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
@dynamic to;
@dynamic subject;
@dynamic date;
@dynamic message;
@dynamic version;
@dynamic id;

-(NSString *)getIdd{
    return self.id;
}
-(NSNumber *)getVersion{
    return self.version;
}

-(void)setDescriptionUsing:(NSDictionary *) item{
    self.id = [item valueForKey:@"_id"];
    self.from = [item valueForKey:@"from"];
    self.to = [item valueForKey:@"simpleTo"];
    self.subject = [item valueForKey:@"subject"];
    self.date = [item valueForKey:@"date"];
    self.message = [item valueForKey:@"location"];
    self.version = [item valueForKey:@"version"];
}

@end
