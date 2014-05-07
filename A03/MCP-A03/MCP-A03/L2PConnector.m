//
//  L2PConnector.m
//  MCP-A03
//
//  Created by Giorgio Pretto on 5/7/14.
//  Copyright (c) 2014 Giorgio Pretto - Devashish Jasani - Kamalika Dutta. All rights reserved.
//

#import "L2PConnector.h"




@implementation L2PConnector

NSURL *apiUrl;
NSURL *oauth2Url;
NSString *codeEndPoint;
NSString *tokenEndPoint;
NSString *appID;
NSDictionary *config;

L2PConnectorState state;


- (id)init {
    self = [super init];
    if (self !=nil) {
        
        // load the configuration
        
        
    }
}

@end
