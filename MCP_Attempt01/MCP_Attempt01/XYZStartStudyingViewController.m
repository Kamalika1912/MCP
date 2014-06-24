//
//  XYZStartStudyingViewController.m
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 22/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import "XYZStartStudyingViewController.h"
#import "XYZMyFlashcardsViewController.h"

@interface XYZStartStudyingViewController ()

@end

@implementation XYZStartStudyingViewController

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
    
    // parent screen hides the navigation bar but it is required here and opposite for the tab bar. Tab bar is not required in the studying mode
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
    
    [[self.favouriteButton imageView] setContentMode: UIViewContentModeScaleAspectFit];
    [self.favouriteButton setImage:[UIImage imageNamed:@"favouriteNotSelected.png"] forState:UIControlStateNormal];
    
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self isMovingFromParentViewController]) {
       
        //this is done to remove the navigation bar from the parent screen as it has the drop down and opposite for the tab bar
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.tabBarController.tabBar.hidden = NO;
        
        
        
        
        
        
        
        
    }
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

- (IBAction)favouriteButtonClicked:(id)sender {
    
    [self.favouriteButton setImage:[UIImage imageNamed:@"favouriteSelected.png"] forState:UIControlStateNormal];
    
    
    
}
@end
