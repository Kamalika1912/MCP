//
//  L2PConnector.h
//  MCP-A03
//
//  Created by Giorgio Pretto on 5/7/14.
//  Copyright (c) 2014 Giorgio Pretto - Devashish Jasani - Kamalika Dutta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface L2PConnector : NSObject

// Used to track the connection status
typedef enum L2PConnectorState : NSInteger {
    NSConnectorStateError = -1,
    NSConnectorStateReady = 0,
    NSConnectorStateConnecting = 1,
    NSConnectorStateWaitingForResponse = 2
} L2PConnectorState;

@end
