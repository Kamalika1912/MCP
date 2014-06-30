//
//  XYZStartupViewController.m
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 10/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import "XYZStartupViewController.h"
#import "XYZDBManager.h"

@interface XYZStartupViewController ()

@end

@implementation XYZStartupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor clearColor ];
    NSArray *result = [[XYZDBManager getSharedInstance] getProfileByProfileID:1];
    [self.username setText:[result objectAtIndex:0]];
    [self.coins setText:[result objectAtIndex:1]];
   
    

    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
