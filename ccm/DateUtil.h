//
//  DateUtil.h
//  ccm
//
//  Created by Brenton Durkee on 8/4/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

+(NSString *) stringFromOldDate:(NSDate *) date;
+(NSDate *) dateFromString:(NSString *) string;
+(NSString *) stringFromDate:(NSDate *) date;
+(NSString *) stringFromDateTil:(NSDate *) date;

@end
