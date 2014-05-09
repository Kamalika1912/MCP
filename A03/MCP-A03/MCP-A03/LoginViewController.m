//
//  FirstViewController.m
//  MCP-A03
//
//  Created by Giorgio Pretto on 5/7/14.
//  Copyright (c) 2014 Giorgio Pretto - Devashish Jasani - Kamalika Dutta. All rights reserved.
//

#import "LoginViewController.h"
#import "L2PConnector.h"
#import "WebViewController.h"

@interface LoginViewController ()
{
    L2PConnector *l2pConn;
    
    // url for requesting the user authorization
    NSURL *verificationUrl;
    
}

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // initilize var
    
    //load an L2P connector
    l2pConn = [[L2PConnector alloc] init];
    

    //Do I have a token already? Otherwise perform the One-Time login
    if (![l2pConn hasToken]){
        
        // show an alert with short instruction for login to let the user know why he is getting redirected
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"First Access"
                                                        message:@"This is your first access to our app. You need to login with your TIM account to use this app."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        
    
    } else {
        // We already got the token, so say Hi to our user, whoever he is (we use the user_code everywere when we need an ID)
        [_welcomeLabel setText:[NSString stringWithFormat:@"Welcome Back Dear %@! \r Whoever you are! \r (we have no way of knowing)",
                                    [[NSUserDefaults standardUserDefaults] valueForKey:@"userCode" ] ]];
        
        
    }
    
    
    
    
}


// ALERT DISSMISSED
// when alert is dismissed, we load the webview
- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    // create the webview from the xib file (just a simple webview inside) and set ourself as delegate
    WebViewController *webVC = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:Nil];
    webVC.delegate=self;
    // retrive the url from the L2PConnector object and open it in the view
    [webVC openURL:[l2pConn getVerificationUrl]];
    // present the view (skip the parameter as modal is default)
    [self presentViewController:webVC animated:YES completion:nil];
    
}



//WEBVIEW finish loading
// This method is invoked by our WebViewController when it's webview reach the succssefull authentication page
//this means that we can now procede with the AccessToken request

- (void)viewIsDone
{
    // dismiss the WebViewController view we called before
    [self dismissViewControllerAnimated:TRUE completion:^{}];
    // ask for the first access token
    if ([l2pConn requestAccessToken]) NSLog(@"%@",@"YEAHHHH");

    // FROM THIS POIN ON WE CAN START USE THE APP

}










// standart stuff
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
