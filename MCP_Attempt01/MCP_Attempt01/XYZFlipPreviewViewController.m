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
    //     self.view.backgroundColor = [UIColor clearColor ];
    
    //instead card data list from the data base
    flashcard = [[XYZFlashcard alloc] init];
    flashcard.flashcardID = 0;
    flashcard.question = question;
    flashcard.answer = answer;
    horizontalScroll.backgroundColor = [UIColor clearColor];
    horizontalScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, 320, 420)];
    horizontalScroll.pagingEnabled=YES;
    
    
    horizontalScroll.contentSize = CGSizeMake(320 , 420);
    horizontalScroll.scrollEnabled = YES;
    horizontalScroll.delegate=self;
    [horizontalScroll setShowsHorizontalScrollIndicator:YES];
    
    
    [self.view addSubview:horizontalScroll];
    
    frontCard = [[XYZFlashcardFront alloc] initWithQuestionForPreview:question withFrame:CGRectMake(0, 65, 320, 420)];
        
    frontCard.frontCoverButton.tag = 0;
    [frontCard.frontCoverButton addTarget:self action:@selector(flipCardToBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [horizontalScroll addSubview:frontCard];
        
        
        
   
    
    
}

-(void)flipCardToBack:(UIButton *)sender {
    
    XYZFlashcardBack *back = [[XYZFlashcardBack alloc] initWithAnswerForPreview:answer withFrame:CGRectMake(0, 65, 320, 420)];
    back.backCoverButton.tag=sender.tag;
    
    [back.backCoverButton addTarget:self action:@selector(flipCardToFront:) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView transitionFromView:[horizontalScroll.subviews objectAtIndex:sender.tag] toView:back duration:1.0f options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        
        [horizontalScroll insertSubview:back atIndex:sender.tag];
        
    }];
}

-(void) flipCardToFront :(UIButton *)sender {
    
    frontCard = [[XYZFlashcardFront alloc] initWithQuestionForPreview:question withFrame:CGRectMake(0, 65, 320, 420)];
    frontCard.frontCoverButton.tag=sender.tag;
    
    [frontCard.frontCoverButton addTarget:self action:@selector(flipCardToBack :) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView transitionFromView:sender.superview toView:frontCard duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
    [ horizontalScroll insertSubview:frontCard atIndex:sender.tag];
        
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

- (long) findIndexOfCurrentCardInFocus
{
    return 0;
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