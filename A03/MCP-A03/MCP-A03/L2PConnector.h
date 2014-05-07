//
//  L2PConnector.h
//  MCP-A03
//
//  Created by Giorgio Pretto on 5/7/14.
//  Copyright (c) 2014 Giorgio Pretto - Devashish Jasani - Kamalika Dutta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface L2PConnector : NSObject<NSURLConnectionDelegate>

// Used to track the connection status
typedef enum L2PConnectorState : NSInteger {
    L2PConnectorStateError = -1,
    L2PConnectorStateReady = 0,
    L2PConnectorStateConnecting = 1,
    L2PConnectorStateWaitingForResponse = 2
} L2PConnectorState;


-(void)requestToken;
-(void)requestDeviceCode;
-(BOOL)hasToken;

@end
