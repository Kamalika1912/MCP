//
//  AppDelegate.m
//  MCP-A03
//
//  Created by Giorgio Pretto on 5/7/14.
//  Copyright (c) 2014 Giorgio Pretto - Devashish Jasani - Kamalika Dutta. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // START UP = HardCode the URL standard informations
    NSUserDefaults *ud =[NSUserDefaults standardUserDefaults];
    [ud setValue:@"l2p2013.rwth" forKey:@"scope"];
    [ud setValue:@"https://oauth.campus.rwth-aachen.de/oauth2waitress/oauth2.svc/token" forKey:@"tokenUrl"];
    [ud setValue:@"https://oauth.campus.rwth-aachen.de/oauth2waitress/oauth2.svc/code" forKey:@"codeUrl"];
    [ud setValue:@"iupSdInI9z1zBvpFZ2u7IirZEhVIul46XkrYa8JVD0iWiip3PQA0th22ZHWliDfw.apps.rwth-aachen.de" forKey:@"clientID"];
    [ud setValue:@"https://www.elearning.rwth-aachen.de/_vti_bin/l2pservices/api.svc/v1/" forKey:@"apiUrl"];
    // need to synchronize manually to see the values on the other classes
    [ud setValue:@"" forKey:@"accessToken"];
    [ud synchronize];
    
    
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
