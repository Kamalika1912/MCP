//
//  FirstViewController.m
//  MCP-A03
//
//  Created by Giorgio Pretto on 5/7/14.
//  Copyright (c) 2014 Giorgio Pretto - Devashish Jasani - Kamalika Dutta. All rights reserved.
//

#import "LoginViewController.h"
#import "L2PConnector.h"

@interface LoginViewController ()
{
    L2PConnector *l2pConn;

    
    
}

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //load an L2P connector
    l2pConn = [[L2PConnector alloc] init];
    
    //Do I have a token already? Otherwise to the One-Time login
    if (![l2pConn hasToken]){
        NSLog(@"%@",@"No token yet. asking for it now..");
            [l2pConn requestDeviceCode];
    } else NSLog(@"%@",@"Got Token");
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
