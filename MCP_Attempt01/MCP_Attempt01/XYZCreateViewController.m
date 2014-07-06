//
//  XYZEditCardViewController.m
//  MCP_Attempt01
//
//  Created by MCP 2014 on 06/07/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import "XYZCreateViewController.h"


@interface XYZCreateViewController ()

@end

@implementation XYZCreateViewController

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
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
    
    //self.cardNumber.text = [NSString stringWithFormat:@"%d of %ld",1,(unsigned long)_myCards.count];
    
    self.horizontalScroll.backgroundColor = [UIColor clearColor];
    self.horizontalScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, 320, 420)];
    self.horizontalScroll.pagingEnabled=YES;
    
    
    self.horizontalScroll.contentSize = CGSizeMake(1, 420);
    self.horizontalScroll.scrollEnabled = YES;
    self.horizontalScroll.delegate=self;
    [self.horizontalScroll setShowsHorizontalScrollIndicator:YES];
    
    [self.view addSubview:self.horizontalScroll];
    
    XYZFlashcard *flashcard;
    flashcard.question=self.question;
    flashcard.answer=self.answer;
    
    XYZFlashcardFront *front = [[XYZFlashcardFront alloc] initWithFlashcardSimple:flashcard  withFrame:CGRectMake(0, 65, 320, 420)];//i 1 to proto
    
    front.frontCoverButton.tag = 0;
    //[front.frontCoverButton addTarget:self action:@selector(flipCardToBackAtPos:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.horizontalScroll addSubview:front];
}


-(void)flipCardToBack:(UIButton *)sender {
    
    XYZFlashcardBack *back = [[XYZFlashcardBack alloc] initWithFlashcard:self.flashCard withFrame:CGRectMake(self.horizontalScroll.frame.size.width*sender.tag, 65, 320, 420)];
    back.backCoverButton.tag=sender.tag;
    
    [back.backCoverButton addTarget:self action:@selector(flipCardToFront:) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView transitionFromView:[self.horizontalScroll.subviews objectAtIndex:sender.tag] toView:back duration:1.0f options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        
        [self.horizontalScroll insertSubview:back atIndex:sender.tag];
        
        
        
    }];
}

-(void) flipCardToFront:(UIButton *)sender {
    
    XYZFlashcardFront *front = [[XYZFlashcardFront alloc] initWithFlashcardSimple: self.flashCard withFrame:CGRectMake(self.horizontalScroll.frame.size.width*sender.tag, 65, 320, 420)];
    front.frontCoverButton.tag=sender.tag;
    
    [front.frontCoverButton addTarget:self action:@selector(flipCardToBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView transitionFromView:sender.superview toView:front duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        
        
        
        [self.horizontalScroll insertSubview:front atIndex:sender.tag];
        
        
        
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
