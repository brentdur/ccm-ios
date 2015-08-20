//
//  Topics.m
//  ccm
//
//  Created by Brenton Durkee on 8/10/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "Topics.h"


@implementation Topics

@dynamic id;
@dynamic name;
@dynamic isAnon;
@dynamic version;

-(NSString *)getIdd{
    return self.id;
}

-(NSNumber *)getVersion{
    return self.version;
}

-(void)setIdd:(NSString *)id{
    self.id = id;
}

-(void)setDescriptionUsing:(NSDictionary *)item{
    self.id = [item valueForKey:@"_id"];
    self.name = [item valueForKey:@"name"];
    self.isAnon = [item valueForKey:@"isAnon"];
    self.version = [item valueForKey:@"version"];
}

@end
