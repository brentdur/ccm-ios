//
//  Conversations.m
//  RUF City Campus
//
//  Created by Brenton Durkee on 11/4/15.
//  Copyright © 2015 Brenton Durkee. All rights reserved.
//

#import "Conversations.h"

@implementation Conversations

-(NSString *) getIdd {
    return [self id];
}

-(NSNumber *) getVersion{
    return [self version];
}

-(void) setIdd:(NSString *) id{
    [self setId:id];
}

-(void) setDescriptionUsing:(NSDictionary *) item{
    
    //TODO store messages as array
    
    [self setId:[item valueForKey:@"_id"]];
    [self setFrom_who:[item valueForKey:@"from_who"]];
    [self setMessages:[item valueForKey:@"messages"]];
    [self setMinmessages:[item valueForKey:@"minmessages"]];
    [self setParticipant:[item valueForKey:@"participant"]];
    [self setSingleton:[item valueForKey:@"singleton"]];
    [self setSubject:[item valueForKey:@"subject"]];
    [self setTopic:[item valueForKey:@"topic"]];
    [self setVersion:[item valueForKey:@"version"]];
    
}

@end
