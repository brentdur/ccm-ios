//
//  AdminRequests.h
//  ccm
//
//  Created by Brenton Durkee on 7/27/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol AdminRequestDelegate;


@interface AdminRequest : NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
+ (AdminRequest *)sharedInstance;

@property NSMutableData *response;
@property id <AdminRequestDelegate> delegate;

-(void) signInEmail:(NSString *)email andPassword:(NSString *)password andDelegate:(id)delegate;
-(void) signUpName:(NSString *)name forEmail:(NSString *) email andPassword:(NSString *)password andDelegate:(id)delegate;
@end

@protocol AdminRequestDelegate

- (void)adminRequest:(AdminRequest *)adminRequest didReturnData:(id)data;
@optional
- (void)adminRequest:(AdminRequest *)adminRequest downloadProgress:(double)progress;
- (void)adminRequest:(AdminRequest *)adminRequest uploadProgress:(double)progress;

@end
