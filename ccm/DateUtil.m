//
//  DateUtil.m
//  ccm
//
//  Created by Brenton Durkee on 8/4/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

+(NSString *) stringFromOldDate:(NSDate *) date{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    date = [df dateFromString:[date description]];
    
    NSTimeInterval distance = [date timeIntervalSinceNow];
    NSLog(@"%f", distance);
    distance = distance / 86400;
    NSLog(@"%f", distance);
    NSString *sDate = [[NSString alloc] init];
    if (distance < -30 || distance >= 1){
        [df setDateFormat:@"MM/dd"];
        sDate = [df stringFromDate:date];
    }
    else {
        distance *= -1;
        sDate = [NSString stringWithFormat:@"%.0f days ago", distance];
    }
    return sDate;
}

+(NSDate *) dateFromString:(NSString *) string {
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    return [df dateFromString:string];
}

+(NSString *) stringFromDate:(NSDate *) date{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    NSTimeInterval distance = [date timeIntervalSinceNow];
    NSLog(@"%f", distance);
    distance = distance / 86400;
    NSLog(@"%f", distance);
    NSString *sDate = [[NSString alloc] init];
    if (distance < -30 || distance >= 1){
        [df setDateFormat:@"MM/dd"];
        sDate = [df stringFromDate:date];
        sDate = [NSString stringWithFormat:@"on %@", sDate];
    }
    else {
        distance *= -1;
        NSString *day = @"days";
        if (distance < 2){
            day = @"day";
        }
        sDate = [NSString stringWithFormat:@"%.0f %@ ago", distance, day];
    }
    return sDate;
}

+(NSString *) stringFromDateTil:(NSDate *) date{

    int distance = [date timeIntervalSinceNow];
    distance += [[NSTimeZone localTimeZone] secondsFromGMTForDate:[NSDate date]];
    
    if(distance < 0){
        return @"started";
    }
    int minutesTil = distance / 60;
    int hoursTil = minutesTil / 60;
    int daysTil = hoursTil / 24;
    NSString *sDate = [NSString stringWithFormat:@"starts in %d days %2d:%02d:%02d", daysTil, hoursTil%24, minutesTil % 60, distance % 60];
    return sDate;
}
@end
