//
//  Locations.m
//  ccm
//
//  Created by Brenton Durkee on 7/29/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "Locations.h"


@implementation Locations

@dynamic name;
@dynamic address;
@dynamic lat;
@dynamic lng;
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
    self.address = [item valueForKey:@"address"];
    self.lat = [item valueForKey:@"lat"];
    self.lng = [item valueForKey:@"lng"];
    self.version = [item valueForKey:@"version"];
}

@end
