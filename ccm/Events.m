//
//  Events.m
//  ccm
//
//  Created by Brenton Durkee on 7/29/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "Events.h"


@implementation Events

@dynamic name;
@dynamic date;
@dynamic location;
@dynamic lat;
@dynamic lng;
@dynamic desc;
@dynamic version;
@dynamic id;

static BOOL update = false;

-(NSString *)getIdd{
    return self.id;
}
-(NSNumber *)getVersion{
    return self.version;
}

-(void)setDescriptionUsing:(NSDictionary *) item{
    self.id = [item valueForKey:@"_id"];
    self.name = [item valueForKey:@"title"];
    self.desc = [item valueForKey:@"description"];
    self.date = [item valueForKey:@"date"];
    self.location = [item valueForKey:@"location"];
    self.lat = [item valueForKey:@"lat"];
    self.lng = [item valueForKey:@"lng"];
    self.version = [item valueForKey:@"version"];
}

+(BOOL) updated{
    return update;
}

+(void) setUp:(BOOL)value{
    update = value;
}

@end
