//
//  L2PConnector.h
//  MCP-A03
//
//  Created by Giorgio Pretto on 5/7/14.
//  Copyright (c) 2014 Giorgio Pretto - Devashish Jasani - Kamalika Dutta. All rights reserved.
//

#import <Foundation/Foundation.h>

// DELEGATE PROTOCOL that whoever wanna use the L2PApi must implement to receive data back
@protocol L2PConnectorDelegate <NSObject>

// return the verification URL to who asked it
-(void)didReceiveVerifcationURL:(NSURL *)verificationURL;

// notify delegate that now he can use the api (after first call or refresh)
-(void)tokenIsValid;


// return the data from the server to the delegate who asked for it
-(void)didReceiveData:(NSDictionary *)data;

// generic notification of error
-(void)didReceiveError;

@end



@interface L2PConnector : NSObject<NSURLConnectionDelegate>


// Used to track the connection status
typedef enum ApiCallName  {
    VerificationURLRequest,
    TokenRequest,
    RefreshTokenRequest,

    //real api names
    ApiCallAnnouncements,
    ApiCallEmails
} ApiCallName;


// delegate object. The class that will managed the response data (ES: the list of announcements)
@property id<L2PConnectorDelegate> delegate;





// Token related api
-(bool)refreshAccessToken;
-(bool)requestAccessToken;
-(void)getVerificationUrl;
-(BOOL)hasToken;




// Api Access Methods
-(void)getL2PDiscussionsForCourse:(NSString *)courseCID;
-(void)getL2PAnnouncementsForCourse:(NSString *)courseCID;

@end
