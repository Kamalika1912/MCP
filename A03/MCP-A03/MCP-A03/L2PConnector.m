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
@property L2PConnectorState state;
@property NSUserDefaults *config ;

@end


@implementation L2PConnector

// private var
bool parseData;


- (id)init {
    self = [super init];
    if (self !=nil) {
        
        // initialize state to READY
        self.state = L2PConnectorStateReady;
        
        // for now NSDefault.
        _config =[NSUserDefaults standardUserDefaults];
        

        // CODE TO LOAD CONFIGURATION FROM FILE INSTEAD OF NSDEFAULT - not used anymore
        // load the configuration
        //        self.configPath = [[NSBundle mainBundle] pathForResource:@"L2PConfig" ofType:@"plist"];
        //        self.config = [NSMutableDictionary dictionaryWithContentsOfFile:self.configPath];

    
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
-(NSURL *)getVerificationUrl
{
    // create the url to be returned
    NSURL * verificationUrl = [NSURL URLWithString:@""];
    
    // create the request for the DEVICE CODE, given the clientID and the scope
    NSURL *requestUrl = [NSURL URLWithString:[_config valueForKey:@"codeUrl"]];
    NSString *bodyString = [NSString stringWithFormat:@"client_id=%@&scope=%@", [_config valueForKey:@"clientID"],[_config valueForKey:@"scope"]];
    NSMutableURLRequest *userCodeRequest = [NSMutableURLRequest requestWithURL:requestUrl];
    [userCodeRequest setHTTPMethod:@"POST"];
    [userCodeRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];

    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:userCodeRequest
                                          returningResponse:&response
                                                      error:&error];

    // this is synchrounous, so we can wait for the answer here.
    // and the user can't do anything with the app unless he's authenticated anyway.. so..
    if (error == nil)
    {
        // load the response into a dictionary
        NSError *e;
        NSDictionary *responseDataDictionary = [NSJSONSerialization JSONObjectWithData: data
                                                                               options: NSJSONReadingMutableContainers
                                                                                 error: &e];

        // we will need the user_code and device_code in the future. so save them in our config
        [_config setValue:responseDataDictionary[@"user_code"] forKey:@"userCode"];
        [_config setValue:responseDataDictionary[@"device_code"] forKey:@"deviceCode"];
        // save them
        [_config synchronize];
        
        // extract the url, composing the basic url and the usercode
        verificationUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@?q=verify&d=%@", responseDataDictionary[@"verification_url"],[_config valueForKey:@"userCode"]]];
        
    }
    // return the url. Hopefully not an empty string
    return verificationUrl;
}






// Request for the first ACCESS TOKEN
// even here the user can't do anything before obtaining it, so we'll stick to synchrounous request

-(bool ) requestAccessToken
{
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









// Copied and lightly modified from the given Example.



// METHOD TO BE CALLED FROM OUR REAL APP

-(void)getL2PCourseRooms
{
    self.state = courseRooms;
    
    NSString *url = @"https://www2.elearning.rwth-aachen.de/L2PWebservices/L2PFoyerService.asmx";
    NSString *bodyString = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCourseRooms xmlns=\"http://cil.rwth-aachen.de/l2p/services\"><userToken>%@</userToken></GetCourseRooms></soap:Body></soap:Envelope>", self.accessToken];
    
    NSMutableURLRequest *courseInfoRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [courseInfoRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [courseInfoRequest addValue:[NSString stringWithFormat:@"%lu", (unsigned long)bodyString.length] forHTTPHeaderField:@"Content-Length"];
    [courseInfoRequest addValue:@"http://cil.rwth-aachen.de/l2p/services/GetCourseRooms" forHTTPHeaderField:@"SOAPAction"];
    [courseInfoRequest setHTTPMethod:@"POST"];
    [courseInfoRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:courseInfoRequest delegate:self startImmediately:YES];
}









// DELEGATE METHOD


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    
    NSString *stringResponseData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",  stringResponseData);
//    if (parseData) {
//        self.xmlParser = [[NSXMLParser alloc] initWithData:data];
//        [self.xmlParser setDelegate:self];
//        [self.xmlParser setShouldProcessNamespaces:YES];
//        [self.xmlParser parse];
//    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@"Recieved response: %@", response);
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger statusCode = [httpResponse statusCode];
    if (statusCode >= 300) {
//        [self.textView setText:[NSString stringWithFormat:@"Error\nHTTP status code: %li", (long)statusCode]];
        
        parseData = NO;
    } else {
        parseData = YES;
    }
}








@end
