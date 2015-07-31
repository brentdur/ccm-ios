//
//  Groups.m
//  ccm
//
//  Created by Brenton Durkee on 7/29/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "Groups.h"


@implementation Groups

@dynamic name;
@dynamic write_talks;
@dynamic write_events;
@dynamic write_msgs;
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
    self.name = [item valueForKey:@"name"];
    self.write_talks = [item valueForKey:@"writeTalks"];
    self.write_events = [item valueForKey:@"writeEvents"];
    self.write_msgs = [item valueForKey:@"writeMsgs"];
    self.version = [item valueForKey:@"version"];
}

@end
