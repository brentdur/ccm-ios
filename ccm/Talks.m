//
//  Talks.m
//  ccm
//
//  Created by Brenton Durkee on 7/29/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "Talks.h"


@implementation Talks

@dynamic author;
@dynamic date;
@dynamic subject;
@dynamic reference;
@dynamic version;
@dynamic outline;
@dynamic fullVerse;
@dynamic id;

-(NSString *)getIdd{
    return self.id;
}
-(NSNumber *)getVersion{
    return self.version;
}

-(void)setDescriptionUsing:(NSDictionary *) item{
    self.id = [item valueForKey:@"_id"];
    self.author = [item valueForKey:@"author"];
    self.subject = [item valueForKey:@"subject"];
    self.date = [DateUtil dateFromString:[item valueForKey:@"date"]];
    self.reference = [item valueForKey:@"reference"];
    self.outline = @"";
    for (id name in [item valueForKey:@"outline"]){
        self.outline = [NSString stringWithFormat:@"%@%@\r", self.outline, name];
    }
    self.fullVerse = [item valueForKey:@"fullVerse"];
    self.version = [item valueForKey:@"version"];
}

@end
