//
//  FirstViewController.h
//  MCP-A03
//
//  Created by Giorgio Pretto on 5/7/14.
//  Copyright (c) 2014 Giorgio Pretto - Devashish Jasani - Kamalika Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "L2PConnector.h"

@interface LoginViewController : UIViewController<WebViewControllerDelegate,UIAlertViewDelegate,L2PConnectorDelegate>

@end
