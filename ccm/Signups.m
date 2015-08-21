//
//  Signups.m
//  ccm
//
//  Created by Brenton Durkee on 8/10/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "Signups.h"


@implementation Signups

@dynamic name;
@dynamic dateInfo;
@dynamic location;
@dynamic address;
@dynamic version;
@dynamic desc;
@dynamic memberCount;
@dynamic memberOf;
@dynamic id;

-(NSString *)getIdd{
    return self.id;
}

-(NSNumber *)getVersion{
    return self.version;
}

-(void)setDescriptionUsing:(NSDictionary *)item{
    self.id = [item valueForKey:@"_id"];
    self.name = [item valueForKey:@"name"];
    self.dateInfo = [item valueForKey:@"dateInfo"];
    self.location = [item valueForKey:@"location"];
    self.address = [item valueForKey:@"address"];
    self.desc = [item valueForKey:@"description"];
    self.memberCount = [item valueForKey:@"memberCount"];
    self.version = [item valueForKey:@"version"];
    self.memberOf = [item valueForKey:@"isMemberOf"];
}

@end
