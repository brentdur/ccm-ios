//
//  AdminRequests.m
//  ccm
//
//  Created by Brenton Durkee on 7/27/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "AdminRequest.h"

@implementation AdminRequest

static AdminRequest *sharedInstance = nil;

+ (AdminRequest *)sharedInstance
{
    //allows only one instance of this to be running at a time
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^
                  {
                      sharedInstance = [[self alloc] init];
                  });
    
    return sharedInstance;
}


-(void) signInEmail:(NSString *)email andPassword:(NSString *)password andDelegate:(id)delegate{
    //asigns delegate, creates body, runs request
    self.delegate = delegate;
    NSString *body = [NSString stringWithFormat:@"email=%@&password=%@", email, password];
    [self requestWithURL:URL_POST_SIGNIN andBody:body];
}

-(void) signUpName:(NSString *)name forEmail:(NSString *) email andPassword:(NSString *)password andDelegate:(id)delegate{
    self.delegate = delegate;
    NSString *body = [NSString stringWithFormat:@"name=%@&password=%@&email=%@", name, password, email];
    [self requestWithURL:URL_POST_SIGNUP andBody:body];
}

-(void) requestWithURL:(NSString *) urlString andBody:(NSString *) body{
    //turns string to url, uses default configuration, opens session with delegate, creates request, sets parameters
    // and runs
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    [[session dataTaskWithRequest:request] resume];
}

#pragma mark - NSURLSessionTaskDelegate Methods
/*
 - (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
 {
 dispatch_async(dispatch_get_main_queue(), ^
 {
 [self.delegate dataManager:self uploadProgress:((double)totalBytesSent / (double)totalBytesExpectedToSend)];
 });
 }*/

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    //first method to fire on response
    NSLog(@"did receive response");
    self.response = [[NSMutableData alloc] init];
    completionHandler(NSURLSessionResponseAllow);
//    self.responseData.length = 0;
//    
//    self.response = (NSHTTPURLResponse *)response;
//    
//    NSInteger status = [self.response statusCode];
//    NSLog(@"Got RESPONSE: %ld", (long)status);
//    
//    if(status == HTTP_CODE_SUCCESS)
//    {
//        completionHandler(NSURLSessionResponseAllow);
//    }
//    else
//    {
//        UIAlertView *alert = [Utils createAlertWithPrefix:STRING_FAILED_REQUEST_PREFIX customMessage:[NSString stringWithFormat:@"Status Code: %li", (long)status] showOther:NO andDelegate:nil];
//        [alert show];
//        
//        NSLog(@"Received bad status code: %li", (long)self.response.statusCode);
//    }
//    
//    self.currentTask = nil;
}
//
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    //second method to fire as data is recieved
    NSLog(@"did recieve data");
    [self.response appendData:data];
    //[self.responseData appendData:data];
}
//
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    //last method to fire when end of response is reached
    NSLog(@"did complete with error: %@", error);
    if(error){
        NSLog(@"ERROR");
    }
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:self.response options:NSJSONReadingMutableContainers error:&error];
    if(error){
        NSLog(@"%@", error);
    }
    NSLog(@"%@", [result valueForKey:@"token"]);
    [self.delegate adminRequest:self didReturnData:[result valueForKey:@"token"]];
    
    //    NSLog(@"completed; error: %@", error);
//    self.currentTask = nil;
//    
//    if(error)
//    {
//        UIAlertView *alert = [Utils createAlertWithPrefix:STRING_FAILED_REQUEST_PREFIX customMessage:[NSString stringWithFormat:@"%@", error.localizedDescription] showOther:NO andDelegate:nil];
//        [alert show];
//    }
//    else
//    {
//        NSString *str = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
//        NSLog(@"\nRESPONSE: %@", str);
//        
//        NSArray *newCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:PEGGSITE_API_URL]];
//        [self updateCookies:newCookies];
//        
//        id jsonData = [self parseJSONResponse:self.responseData];
//        
//        if(self.delegate)
//            [self.delegate dataManager:self didReturnData:jsonData];
//        
//    }
}

/*
 - (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
 {
 if(error)
 {
 UIAlertView *alert = [Utils createAlertWithPrefix:STRING_FAILED_REQUEST_PREFIX customMessage:[NSString stringWithFormat:@"%@", error.localizedDescription] showOther:NO andDelegate:nil];
 [alert show];
 }
 else
 {
 
 }
 }
 - (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
 {
 NSURLCredential *credential = [NSURLCredential credentialWithUser:self.userName password:self.password persistence:NSURLCredentialPersistenceForSession];
 [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
 }
 - (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest *))completionHandler
 {
 
 }
 */
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
//    NSURLCredential *credential = [NSURLCredential credentialWithUser:self.userName password:self.password persistence:NSURLCredentialPersistenceForSession];
//    [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
//    completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
}

@end
