//
//  L2PConnector.m
//  MCP-A03
//
//  Created by Giorgio Pretto on 5/7/14.
//  Copyright (c) 2014 Giorgio Pretto - Devashish Jasani - Kamalika Dutta. All rights reserved.
//

#import "L2PConnector.h"

@interface L2PConnector ()

// Private properties
@property NSURLConnection *connection;
@property NSDictionary *config;
@property L2PConnectorState state;

@end


@implementation L2PConnector


- (id)init {
    self = [super init];
    if (self !=nil) {
        
        // initialize state to READY
        self.state = L2PConnectorStateReady;
        
        // load the configuration
        NSString *configPath = [[NSBundle mainBundle] pathForResource:@"L2PConfig" ofType:@"plist"];
        self.config = [NSDictionary dictionaryWithContentsOfFile:configPath];
        
        // debug
        NSLog(@"%@",self.config[@"codeUrl"]);
        NSLog(@"%@",self.config[@"tokenUrl"]);
        NSLog(@"%@",self.config[@"clientID"]);
        
    }
    return self;
}



-(BOOL)hasToken{
    return !([@"" isEqual:self.config[@"token"]]);
}



// request the device Code to use in the token request
-(void)requestDeviceCode
{
    //the example was using : "l2p.rwth userinfo.rwth"      as scope. ?!?
    
    
    NSURL *requestUrl = [NSURL URLWithString:self.config[@"codeUrl"]];
    NSString *bodyString = [NSString stringWithFormat:@"client_id=%@&scope=%@", self.config[@"clientID"],self.config[@"scope"]];
    
    NSMutableURLRequest *userCodeRequest = [NSMutableURLRequest requestWithURL:requestUrl];
    [userCodeRequest setHTTPMethod:@"POST"];
    [userCodeRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
  
    //NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:userCodeRequest
                                          returningResponse:&response
                                                      error:&error];
    
    if (error == nil)
    {
        NSLog(@"%@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] );
    } else NSLog(@"%@" , @"NOPE");
    
//    self.connection = [[NSURLConnection alloc] initWithRequest:userCodeRequest delegate:self startImmediately:YES];

}



// request the first time token
// need to have already the clientID and the deviceCode
-(void)requestToken
{
//    [self requestDeviceCode];
}








-(NSURL *)getVerificationUrl
{
    // create the url to be returned
    NSURL * verificationUrl = [NSURL URLWithString:@""];
    
    NSURL *requestUrl = [NSURL URLWithString:self.config[@"codeUrl"]];
    NSString *bodyString = [NSString stringWithFormat:@"client_id=%@&scope=%@", self.config[@"clientID"],self.config[@"scope"]];
    
    NSMutableURLRequest *userCodeRequest = [NSMutableURLRequest requestWithURL:requestUrl];
    [userCodeRequest setHTTPMethod:@"POST"];
    [userCodeRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:userCodeRequest
                                          returningResponse:&response
                                                      error:&error];
    
    if (error == nil)
    {
        NSString *stringResponseData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",  stringResponseData);
        
        NSError *e;
        NSDictionary *responseDataDictionary =
        [NSJSONSerialization JSONObjectWithData: data
                                        options: NSJSONReadingMutableContainers
                                          error: &e];
        
//        NSDictionary *responseDataDictionary = [NSDictionary dictionaryWithObject:data] ;
        verificationUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@?q=verify&d=%@", responseDataDictionary[@"verification_url"],responseDataDictionary[@"user_code"]]];
        
    } else NSLog(@"%@" , @"NOPE");

    // return the url. Hopefully not an empty string
    return verificationUrl;
}







//-(NSString *) requestAccessToken
//{
//    NSURL *requestUrl = [NSURL URLWithString:config[@"tokenUrl"]];
//    NSString *bodyString = [NSString stringWithFormat:@"client_id=%s&code=%@&grant_type=device", config[@"clientID"], self.deviceCode];
//    
//    NSMutableURLRequest *tokenRequest = [NSMutableURLRequest requestWithURL:requestUrl];
//    [tokenRequest setHTTPMethod:@"POST"];
//    [tokenRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    self.tokenURLConnection = [[NSURLConnection alloc] initWithRequest:tokenRequest delegate:self startImmediately:YES];
//}

@end
