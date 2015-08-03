//
//  DataRequests.m
//  ccm
//
//  Created by Brenton Durkee on 7/29/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "DataRequest.h"
#import "Constaints.h"

@implementation DataRequest

static DataRequest *sharedInstance = nil;


+(DataRequest *) sharedInstance {
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^
                  {
                      sharedInstance = [[self alloc]init];
                  });
    return sharedInstance;
}

-(void) updateEventsWithDelegate:(id)delegate {
    self.delegate = delegate;
    [self requestWithURL:URL_GET_EVENTS];
}

-(void) updateMessagesWithDelegate:(id)delegate {
    self.delegate = delegate;
    [self requestWithURL:URL_GET_MESSAGES];
}

-(void) updateTalksWithDelegate:(id)delegate {
    self.delegate = delegate;
    [self requestWithURL:URL_GET_TALKS];
}

-(void) updateGroupsWithDelegate:(id)delegate {
    self.delegate = delegate;
    [self requestWithURL:URL_GET_GROUPS];
}

-(void) updateLocationsWithDelegate:(id)delegate {
    self.delegate = delegate;
    [self requestWithURL:URL_GET_LOCATIONS];
}

-(void) updateEventsUsingBlock:(void (^)(NSMutableArray * data, NSError * error)) handler {
    [self AFrequestWithURl:URL_GET_EVENTS returnTo:handler];
}
-(void) updateMessagesUsingBlock:(void (^)(NSMutableArray * data, NSError * error)) handler {
    [self AFrequestWithURl:URL_GET_MESSAGES returnTo:handler];
}
-(void) updateTalksUsingBlock:(void (^)(NSMutableArray * data, NSError * error)) handler {
    [self AFrequestWithURl:URL_GET_TALKS returnTo:handler];
}
-(void) updateGroupsUsingBlock:(void (^)(NSMutableArray * data, NSError * error)) handler {
    [self AFrequestWithURl:URL_GET_GROUPS returnTo:handler];
}
-(void) updateLocationsUsingBlock:(void (^)(NSMutableArray * data, NSError * error)) handler {
    [self AFrequestWithURl:URL_GET_LOCATIONS returnTo:handler];
}

-(void) requestWithURL:(NSString *) urlString{
    

    NSString *key = (NSString *)[KeychainItemWrapper load:KEYCHAIN_KEY_TOKEN];
    //turns string to url, uses default configuration, opens session with delegate, creates request, sets parameters
    // and runs
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:[NSString stringWithFormat:@"Bearer %@", key] forHTTPHeaderField:@"Authorization"];
    request.HTTPMethod = @"GET";
    [session class];
    [[session dataTaskWithRequest:request] resume];
}

-(void) AFrequestWithURl:(NSString *) urlString returnTo:(void (^)(NSMutableArray * data, NSError * error)) handler {
    
    NSString *key = (NSString *)[KeychainItemWrapper load:KEYCHAIN_KEY_TOKEN];
    //turns string to url, uses default configuration, opens session with delegate, creates request, sets parameters
    // and runs
    NSURL *url = [[NSURL alloc] initWithString:urlString];
//    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:[NSString stringWithFormat:@"Bearer %@", key] forHTTPHeaderField:@"Authorization"];
    request.HTTPMethod = @"GET";
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers]];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSError *error = nil;
        
        NSLog(@"AF: data recieved");
        NSMutableArray *dic = (NSMutableArray *) responseObject;
        handler(dic, error);
        
    } failure:^(AFHTTPRequestOperation * op, NSError * error) {
        NSLog(@"error");
    }];
    
    [op start];
    
}


#pragma mark - NSURLSessionTaskDelegate Methods
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{

    NSHTTPURLResponse *res = (NSHTTPURLResponse *) response;
    //first method to fire on response
    NSLog(@"did receive response, status: %ld", (long)[res statusCode]);
    
    if ([res statusCode] == 200) {
//        self.response = [[NSMutableData alloc] init];
        [self.data setObject:[[NSMutableData alloc] init] forKey:[[response URL] absoluteString]];
        completionHandler(NSURLSessionResponseAllow);
    }
    else {
        NSLog(@"not 200");
    }
    
}

#pragma mark - NSURLSessionDataDelegate Methods
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    //second method to fire as data is recieved
    NSLog(@"did recieve data");
//    [self.response appendData:data];
//    [self.data setValue:[[self.data valueForKey:[[[dataTask currentRequest] URL] absoluteString]] appendData:data] forKey:[[dataTask currentRequest] URL] absoluteString]];
    //
    NSLog(@"%@", [self.data objectForKey:[[[dataTask currentRequest] URL] absoluteString]]);
    
}

#pragma mark - NSURLSessionDelegate Methods
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    //last method to fire when end of response is reached
    NSLog(@"did complete with error: %@", error);
    if(error){
        NSLog(@"ERROR");
    }
    NSLog(@"%@", [self.data valueForKey:[[[task currentRequest] URL] absoluteString]]);
//    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:self.response options:NSJSONReadingMutableContainers error:&error];
    NSMutableArray *ar = [[NSMutableArray alloc] initWithArray:[NSJSONSerialization JSONObjectWithData:[self.data objectForKey:[[[task currentRequest] URL] absoluteString]] options:NSJSONReadingAllowFragments error:&error]];
    if(error){
        NSLog(@"%@", error);
    }
    for (NSMutableDictionary *object in ar){
        NSLog(@"%@", object);
    }

    NSString *type = [[[task currentRequest] URL] absoluteString];
    NSLog(@"%@", type);
    [self.delegate dataRequest:self didReturnData:ar forType:type];
}

@end