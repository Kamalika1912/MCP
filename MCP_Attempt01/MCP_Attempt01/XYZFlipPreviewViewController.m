//
//  XYZFlipPreviewViewController.m
//  MCP_Attempt01
//
//  Created by MCP 2014 on 30/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import "XYZFlipPreviewViewController.h"


@interface XYZFlipPreviewViewController ()

@end

@implementation XYZFlipPreviewViewController
@synthesize tagLabel, tag, answer, question;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // parent screen hides the navigation bar but it is required here and opposite for the tab bar. Tab bar is not required in the studying mode
    self.tabBarController.tabBar.hidden = YES;
    //     self.view.backgroundColor = [UIColor clearColor ];
    [self initCard];
    frontCard = [[XYZFlashcardFront alloc] initWithQuestionForPreview:question];
    backCard=[[XYZFlashcardBack alloc]initWithQuestionForPreview:answer];
    
    [frontCard.frontCoverButton addTarget:self action:@selector(flipCardToBack:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)flipCardToBack:(UIButton *)sender {

    backCard.backCoverButton.tag=sender.tag;
    
    [backCard.backCoverButton addTarget:self action:@selector(flipCardToFront:) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView transitionFromView:sender.superview toView:backCard  duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
    }];
    
    
}

-(void) flipCardToFront:(UIButton *)sender {
    
    
frontCard.frontCoverButton.tag=sender.tag;
    
    [frontCard.frontCoverButton addTarget:self action:@selector(flipCardToBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView transitionFromView:sender.superview toView:frontCard duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        
    }];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self isMovingFromParentViewController]) {
        //this is done to remove the navigation bar from the parent screen as it has the drop down and opposite for the tab bar
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.tabBarController.tabBar.hidden = NO;
    }
}

- (void) initCard
{
    flashcard = [[XYZFlashcard alloc] init];
    flashcard.question = question;
    flashcard.answer = answer;
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
- (IBAction)SubmitCard:(id)sender {
    UIAlertView *messageAllert =[[UIAlertView alloc]initWithTitle:@"Success" message:@"Card Submited" delegate:nil    cancelButtonTitle: @"OK" otherButtonTitles: nil];
    [messageAllert show];
}
@end