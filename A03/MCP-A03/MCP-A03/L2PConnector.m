//
//  L2PConnector.m
//  MCP-A03
//
//
//  This connector will check if the token is valid at EVERY call.
//  If the time is almost up (2min lag) we will renew before calling the api.
//  everything is kept internal, the api selector and its parameter are stored for use with a new token
//
//  The architecture is based on the delegation, as showed too in the Example

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

// selector to be call. in case we need to refresh the token before
// calling the api, we need to put it on hold
@property SEL apiCall;
//@property NSInvocation *apiInvocation;

// SHOULD EXTEND TO SUPPORT MULTIPLE PARAMETER FOR CALLBACK ! but for this exercise this is enough
// callback parameter to be passed to the callback api
@property NSString *storedCourseCID;

@end


@implementation L2PConnector

// private var
bool parseData;



- (id)init {
    self = [super init];
    if (self !=nil) {
        
        // read the config from the NSDefault (initialized hardcoded in AppDelegate.m)
        _config =[NSUserDefaults standardUserDefaults];
    
        //set the apiCall callback to nil
        _apiCall = nil;
    }
    return self;
}


// INTERNAL UTILITY METHODS

// check if we already did the authentication (aka if we have the token)
-(BOOL)hasToken
{
    return !([@"" isEqual:[_config valueForKey:@"accessToken"]]);
}

// check if we need to refresh the token before a call
-(BOOL)needToRefreshToken
{
    NSInteger now = [NSDate date].timeIntervalSince1970;
    NSInteger lastRefresh = [(NSDate *)[_config objectForKey:@"lastRefreshDate"] timeIntervalSince1970];
    NSInteger tokenExpiresIn = [_config integerForKey:@"tokenExpiresIn"];
//    NSInteger tokenExpireDate = [(NSDate *)[_config objectForKey:@"tokenExpireDate"] timeIntervalSince1970 ] ;
//    return true;
    //insert 2 minutes for safety, just to not run request with token that may exires during the connection time;
    return (now - lastRefresh - 2*60 > tokenExpiresIn);
}






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
    // launch the connection
    self.connection = [[NSURLConnection alloc] initWithRequest:userCodeRequest delegate:self startImmediately:YES];
}






// Request for the first ACCESS TOKEN
// even here the user can't do anything before obtaining it, so we'll stick to synchrounous request

-(void) requestAccessToken
{
    _lastCall = AccessTokenRequest;
    
    NSURL *requestUrl = [NSURL URLWithString:[_config valueForKey:@"tokenUrl"]];
    NSString *bodyString = [NSString stringWithFormat:@"client_id=%@&code=%@&grant_type=device", [_config valueForKey:@"clientID"], [_config valueForKey:@"deviceCode"]];
    
    NSMutableURLRequest *tokenRequest = [NSMutableURLRequest requestWithURL:requestUrl];
    [tokenRequest setHTTPMethod:@"POST"];
    [tokenRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    self.connection = [[NSURLConnection alloc] initWithRequest:tokenRequest delegate:self startImmediately:YES];
}

-(void)refreshAccessToken
{
    _lastCall = RefreshTokenRequest;
    
    NSURL *requestUrl = [NSURL URLWithString:[_config valueForKey:@"tokenUrl"]];
    NSString *bodyString = [NSString stringWithFormat:@"client_id=%@&refresh_token=%@&grant_type=refresh_token", [_config valueForKey:@"clientID"], [_config valueForKey:@"refreshToken"]];
    
    NSMutableURLRequest *tokenRequest = [NSMutableURLRequest requestWithURL:requestUrl];
    [tokenRequest setHTTPMethod:@"POST"];
    [tokenRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    [tokenRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    self.connection = [[NSURLConnection alloc] initWithRequest:tokenRequest delegate:self startImmediately:YES];
}











// METHODS TO BE CALLED FROM OUR REAL APP
// Inspired, but Heavily modified from Example (the example wasn't using l2p api. not the one we are supposed to use anyway - No need for XML/SOAP)

-(void)getL2PAnnouncementsForCourse:(NSString *)courseCID
{
    // first we'll need to see if we need to refresh the access token
    if ([self needToRefreshToken]) {
        // if so, we need to create the callback invocation to this method again. after the refresh
        _storedCourseCID = courseCID;
        _apiCall = @selector(getL2PAnnouncementsForCourse:);
        
        // then we refresh the token
        [self refreshAccessToken];
        
    } else { // go on if the token is ok
        _lastCall = ApiCallAnnouncements;
        // compose the URL by 3 part : API endpoint URL + method name + parameters  (no need for body cause apis are GET)
        NSString *parameterString = [NSString stringWithFormat:@"accessToken=%@&cid=%@", [_config valueForKey:@"accessToken"],courseCID];
        NSString *url = [NSString stringWithFormat:@"%@%@?%@",[_config valueForKey:@"apiUrl"], @"viewAllAnnouncements", parameterString];
        // create the request for the URL
        NSMutableURLRequest *Request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        // start the connection
        self.connection = [[NSURLConnection alloc] initWithRequest:Request delegate:self startImmediately:YES];
    }
}


// get the hyperlinks
-(void)getL2PHyperlinksForCourse:(NSString *)courseCID
{
    // first we'll need to see if we need to refresh the access token
    if ([self needToRefreshToken]) {
        // if so, we need to create the callback invocation to this method again. after the refresh
        _storedCourseCID = courseCID;
        _apiCall = @selector(getL2PHyperlinksForCourse:);
        
        // then we refresh the token
        [self refreshAccessToken];
        
    } else { // go on if the token is ok
        _lastCall = ApiCallHyperlinks;
        // compose the URL by 3 part : API endpoint URL + method name + parameters  (no need for body cause apis are GET)
        NSString *parameterString = [NSString stringWithFormat:@"accessToken=%@&cid=%@", [_config valueForKey:@"accessToken"],courseCID];
        NSString *url = [NSString stringWithFormat:@"%@%@?%@",[_config valueForKey:@"apiUrl"], @"viewAllHyperlinks", parameterString];
        // create the request for the URL
        NSMutableURLRequest *Request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        // start the connection
        self.connection = [[NSURLConnection alloc] initWithRequest:Request delegate:self startImmediately:YES];
    }
}






//METHODS THAT HANDLE PARSED DATA AND RETURN THEM TO THE DELEGATE WHO ASKED FOR THEM (or handle them internally if about token)


-(void)handleAnnouncementsResults:(NSDictionary *)data
{
    // for this call we only want to pass back the dataset.
    // so the delegate have the array of object without further data managment necessary
    [_delegate didReceiveData:[data objectForKey:@"dataSet"]];
}

-(void)handleHyperlinksResults:(NSDictionary *)data
{
    // for this call we only want to pass back the dataset.
    // so the delegate have the array of object without further data managment necessary
    [_delegate didReceiveData:[data objectForKey:@"listOfHyperlinks"]];
}




// TOKEN MANAGEMENT
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


-(void)handleAccessTokenResults:(NSDictionary *)data
{
    //TODO store interval, and implement the automatic refresh mechanism
    
    // save the tokens in our config
    [_config setValue:data[@"refresh_token"] forKey:@"refreshToken"];
    [_config setValue:data[@"access_token"] forKey:@"accessToken"];
    [_config synchronize];
  
    
    // notify the delegate that we have now a working token
//    [self tokenIsValid];
}

// I just refresh the token. this means that I have been called because one request
// check the timing and the token was close to the expiration date.
// now i will need then to recall it. (stored in _apiCall)

-(void)handleRefreshTokenResults:(NSDictionary *)data
{
    
    // save the new tokens in our config
    [_config setValue:data[@"access_token"] forKey:@"accessToken"];
    // update the other config options
    [_config setInteger: (int)data[@"expires_in"] forKey:@"tokenExpiresIn"];
    NSLog(@"%@",data[@"expires_in"]);
    [_config setObject:[NSDate date] forKey:@"lastRefreshDate"];
//    [_config setObject:[NSDate dateWithTimeIntervalSinceNow:[data[@"expires_in"] integerValue] * 60 - 30] forKey:@"tokenExpireDate"];
    [_config synchronize];
    
NSLog(@"%@",[_config valueForKey:@"tokenExpiresIn"]);
    
    // we were most likely called by one of the apis that needed a new token.
    // check if that's the case and go back to that api call
    if (_apiCall!=nil){
        [self performSelector:_apiCall withObject:_storedCourseCID ];
         _apiCall = nil;
    }

    
}







//
// INTERNAL DELEGATE METHOD TO HANDLE RESPONSES FROM SERVER AND PARSE THEM
//


// Parse the received data into NSDictionary
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
// Copied and lightly modified from the given Example.
{
//    // log the response
    NSString *stringResponseData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",  stringResponseData);
    
    NSLog(@"%@", [_config valueForKey:@"accessToken"]);
    
    
    NSDictionary *responseDataDictionary = nil;
    
    if (parseData) {
        // load the response into a dictionary
        NSError *e;
        responseDataDictionary = [NSJSONSerialization JSONObjectWithData: data
                                                                 options: NSJSONReadingMutableContainers
                                                                   error: &e];
    }
    
    
    // if no error on parsing, handle the data depending on where they come from
    if (responseDataDictionary!=nil) {
        
        switch ( _lastCall ) {
                
                // actual api
            case ApiCallAnnouncements:
                [self handleAnnouncementsResults:responseDataDictionary];
                break;
            case ApiCallHyperlinks:
                [self handleHyperlinksResults:responseDataDictionary];
                break;
                
                
                // token management
            case VerificationURLRequest:
                [self handleVerificationURLResults:responseDataDictionary];
                break;
                
            case AccessTokenRequest:
                [self handleAccessTokenResults:responseDataDictionary];
                break;
                
            case RefreshTokenRequest:
                [self handleRefreshTokenResults:responseDataDictionary];
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
    NSLog(@"%d",  (int)statusCode);
//    NSLog(@"%@", [NSString stringWithFormat:@"%@",  httpResponse]);
    if (statusCode >= 300) {
        
        // call method on delegate
        [_delegate didReceiveError:statusCode];
        
        parseData = NO;
    } else {
        parseData = YES;
    }
}








@end
