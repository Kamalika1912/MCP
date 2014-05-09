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
@property NSString *configPath;
@property NSUserDefaults *config ;
// enum used to track which request i need to handle
@property ApiCallName lastCall;

@end


@implementation L2PConnector

// private var
bool parseData;



- (id)init {
    self = [super init];
    if (self !=nil) {
        
        
        // read the config from the NSDefault (initialized hardcoded in AppDelegate.m)
        _config =[NSUserDefaults standardUserDefaults];
    
    }
    return self;
}


// check if we already did the authentication (aka if we have the token)
-(BOOL)hasToken{
    return !([@"" isEqual:[_config valueForKey:@"accessToken"]]);
}



// request the device Code to use in the token request
-(void)requestDeviceCode
{

    NSURL *requestUrl = [NSURL URLWithString:[_config valueForKey:@"codeUrl"]];
    NSString *bodyString = [NSString stringWithFormat:@"client_id=%@&scope=%@", [_config valueForKey:@"clientID"],[_config valueForKey:@"scope"]];
    
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



// this is now SYNCHRONOUS
// obtain the url for the first authorization request
// do to do, we ask for the DEVICE CODE, and use it to ask the server for the url
-(void)getVerificationUrl
{
    // set the type of call
    _lastCall = VerificationURLRequest;
    
    // create the request for the DEVICE CODE, given the clientID and the scope
    NSURL *requestUrl = [NSURL URLWithString:[_config valueForKey:@"codeUrl"]];
    NSString *bodyString = [NSString stringWithFormat:@"client_id=%@&scope=%@", [_config valueForKey:@"clientID"],[_config valueForKey:@"scope"]];
    NSMutableURLRequest *userCodeRequest = [NSMutableURLRequest requestWithURL:requestUrl];
    [userCodeRequest setHTTPMethod:@"POST"];
    [userCodeRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];

    self.connection = [[NSURLConnection alloc] initWithRequest:userCodeRequest delegate:self startImmediately:YES];
    
//    NSURLResponse * response = nil;
//    NSError * error = nil;
//    NSData * data = [NSURLConnection sendSynchronousRequest:userCodeRequest
//                                          returningResponse:&response
//                                                      error:&error];
//
//    // this is synchrounous, so we can wait for the answer here.
//    // and the user can't do anything with the app unless he's authenticated anyway.. so..
//    if (error == nil)
//    {
//        // load the response into a dictionary
//        NSError *e;
//        NSDictionary *responseDataDictionary = [NSJSONSerialization JSONObjectWithData: data
//                                                                               options: NSJSONReadingMutableContainers
//                                                                                 error: &e];
//
//        // we will need the user_code and device_code in the future. so save them in our config
//        [_config setValue:responseDataDictionary[@"user_code"] forKey:@"userCode"];
//        [_config setValue:responseDataDictionary[@"device_code"] forKey:@"deviceCode"];
//        // save them
//        [_config synchronize];
//        
//        // extract the url, composing the basic url and the usercode
//        verificationUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@?q=verify&d=%@", responseDataDictionary[@"verification_url"],[_config valueForKey:@"userCode"]]];
//        
//    }
//    // return the url. Hopefully not an empty string
//    return verificationUrl;
}






// Request for the first ACCESS TOKEN
// even here the user can't do anything before obtaining it, so we'll stick to synchrounous request

-(bool ) requestAccessToken
{
    _lastCall = RefreshTokenRequest;
    
    NSURL *requestUrl = [NSURL URLWithString:[_config valueForKey:@"tokenUrl"]];
    NSString *bodyString = [NSString stringWithFormat:@"client_id=%@&code=%@&grant_type=device", [_config valueForKey:@"clientID"], [_config valueForKey:@"deviceCode"]];
    
    NSMutableURLRequest *tokenRequest = [NSMutableURLRequest requestWithURL:requestUrl];
    [tokenRequest setHTTPMethod:@"POST"];
    [tokenRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:tokenRequest
                                          returningResponse:&response
                                                      error:&error];
    if (error == nil)
    {
                NSString *stringResponseData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@",  stringResponseData);
        
        // load the response into a dictionary
        NSError *e;
        NSDictionary *responseDataDictionary = [NSJSONSerialization JSONObjectWithData: data
                                                                               options: NSJSONReadingMutableContainers
                                                                                 error: &e];
        // check that the response is successfull
        if ([responseDataDictionary[@"status"] rangeOfString:@"error"].location == NSNotFound) {
           
            //LOG
            NSLog(@"%@%@",@" accessToken = ",responseDataDictionary[@"access_token"]);
            NSLog(@"%@%@",@" accessToken = ",responseDataDictionary[@"refresh_token"]);
            
            // we will need the user_code and device_code in the future. so save them in our config
            [_config setValue:responseDataDictionary[@"refresh_token"] forKey:@"refreshToken"];
            [_config setValue:responseDataDictionary[@"access_token"] forKey:@"accessToken"];
            // save them
            [_config synchronize];
            
            return TRUE;
        } else {
            NSLog(@"%@",@" ERROOOOORR ");
            return FALSE;
        }

        
    } else return FALSE;
    
}

-(bool)refreshAccessToken
{
    NSURL *requestUrl = [NSURL URLWithString:[_config valueForKey:@"tokenUrl"]];
    NSString *bodyString = [NSString stringWithFormat:@"client_id=%@&refresh_token=%@&grant_type=refresh_token", [_config valueForKey:@"clientID"], [_config valueForKey:@"refreshToken"]];
    
    NSMutableURLRequest *tokenRequest = [NSMutableURLRequest requestWithURL:requestUrl];
    [tokenRequest setHTTPMethod:@"POST"];
    [tokenRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    [tokenRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:tokenRequest
                                          returningResponse:&response
                                                      error:&error];
    if (error == nil)
    {
        NSString *stringResponseData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",  stringResponseData);
        
        // load the response into a dictionary
        NSError *e;
        NSDictionary *responseDataDictionary = [NSJSONSerialization JSONObjectWithData: data
                                                                               options: NSJSONReadingMutableContainers
                                                                                 error: &e];
        // check that the response is successfull
        if ([responseDataDictionary[@"status"] rangeOfString:@"error"].location == NSNotFound) {
            
            //LOG
            NSLog(@"%@%@",@" accessToken = ",responseDataDictionary[@"access_token"]);
//            NSLog(@"%@%@",@" accessToken = ",responseDataDictionary[@"refresh_token"]);
            
            // we will need the user_code and device_code in the future. so save them in our config
//            [_config setValue:responseDataDictionary[@"refresh_token"] forKey:@"refreshToken"];
            [_config setValue:responseDataDictionary[@"access_token"] forKey:@"accessToken"];
            // save them
            [_config synchronize];
            
            return TRUE;
        } else {
            NSLog(@"%@",@" ERROOOOORR ");
            return FALSE;
        }
        
        
    } else return FALSE;

}










// METHODS TO BE CALLED FROM OUR REAL APP

// Inspired, but Heavily modified from Example (the example wasn't using l2p api. not the one we are supposed to use anyway - No need for XML/SOAP)
-(void)getL2PDiscussionsForCourse:(NSString *)courseCID
{
//    _lastCall = ApiCallEmails
    // compose the URL by 3 part : API endpoint URL + method name + parameters  (no need for body cause apis are GET)
    NSString *parameterString = [NSString stringWithFormat:@"accessToken=%@&cid=%@", [_config valueForKey:@"accessToken"],courseCID];
    NSString *url = [NSString stringWithFormat:@"%@%@?%@",[_config valueForKey:@"apiUrl"], @"viewAllDiscussionItems", parameterString];
    // create the request for the URL
    NSMutableURLRequest *discussionsRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[url stringByAppendingString:parameterString]]];
    // start the connection
    self.connection = [[NSURLConnection alloc] initWithRequest:discussionsRequest delegate:self startImmediately:YES];
}

-(void)getL2PAnnouncementsForCourse:(NSString *)courseCID
{
    _lastCall = ApiCallAnnouncements;
    
    // compose the URL by 3 part : API endpoint URL + method name + parameters  (no need for body cause apis are GET)
    NSString *parameterString = [NSString stringWithFormat:@"accessToken=%@&cid=%@", [_config valueForKey:@"accessToken"],courseCID];
    NSString *url = [NSString stringWithFormat:@"%@%@?%@",[_config valueForKey:@"apiUrl"], @"viewAllDiscussionItems", parameterString];
    // create the request for the URL
    NSMutableURLRequest *discussionsRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[url stringByAppendingString:parameterString]]];
    // start the connection
    self.connection = [[NSURLConnection alloc] initWithRequest:discussionsRequest delegate:self startImmediately:YES];
}






//METHODS THAT HANDLE PARSED DATA AND RETURN THEM TO THE DELEGATE WHO ASKED FOR THEM


-(void)handleAnnouncementsResults:(NSDictionary *)data
{
    // just pass the data to the delegate
    [_delegate didReceiveData:data];
}


-(void)handleVerificationURLResults:(NSDictionary *)data
{
    
    // we will need the user_code and device_code in the future. so save them in our config
    [_config setValue:data[@"user_code"] forKey:@"userCode"];
    [_config setValue:data[@"device_code"] forKey:@"deviceCode"];
    // actually save them
    [_config synchronize];
   
    // create the verificationURL
    NSURL *verificationUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@?q=verify&d=%@", data[@"verification_url"],[_config valueForKey:@"userCode"]]];
    
    // return the verificationURL
    [_delegate didReceiveVerifcationURL:verificationUrl];
}








//
// INTERNAL DELEGATE METHOD TO HANDLE RESPONSES FROM SERVER
//


// Parse the received data into NSDictionary
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
// Copied and lightly modified from the given Example.
{
    
    // log the response
    NSString *stringResponseData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",  stringResponseData);
  
    // load the response into a dictionary
    NSError *e;
    NSDictionary *responseDataDictionary = [NSJSONSerialization JSONObjectWithData: data
                                                                           options: NSJSONReadingMutableContainers
                                                                             error: &e];

    // if no error on parsing, handle the data depending on where they come from
    if (responseDataDictionary!=nil) {
        
        switch ( _lastCall ) {
            case ApiCallAnnouncements:
                [self handleAnnouncementsResults:responseDataDictionary];
                break;
                
            case VerificationURLRequest:
                [self handleVerificationURLResults:responseDataDictionary];
                break;
            default:
                break;
        }
        
    }
    


}


// Copied and lightly modified from the given Example.
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger statusCode = [httpResponse statusCode];
    NSLog(@"%d",  statusCode);
    if (statusCode >= 300) {

        // call method on delegate
//      [delegate didReceiveError( RETRIVE THE ERROR FROM THE RESPONSE );
        
        parseData = NO;
    } else {
        parseData = YES;
    }
}








@end
