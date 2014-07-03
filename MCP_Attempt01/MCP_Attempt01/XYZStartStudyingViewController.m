//
//  XYZStartStudyingViewController.m
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 22/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import "XYZStartStudyingViewController.h"
#import "XYZMyFlashcardsViewController.h"
#import "XYZFlashcard.h"
#import "XYZFlashcardFront.h"
#import "XYZFlashcardBack.h"

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
   //  self.view.backgroundColor = [UIColor clearColor ];
    [self loadMyCardList];

    
    [[self.favouriteButton imageView] setContentMode: UIViewContentModeScaleAspectFit];
    
    XYZFlashcard *first = [myCardsList objectAtIndex:0];
    
    if(first.addedToFavourites)
    {
    [self.favouriteButton setImage:[UIImage imageNamed:@"favouriteSelected.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.favouriteButton setImage:[UIImage imageNamed:@"favouriteNotSelected.png"] forState:UIControlStateNormal];
        
    }
    
    self.cardNumber.text = [NSString stringWithFormat:@"%d of %ld",1,(unsigned long)myCardsList.count];
    
    self.horizontalScroll.backgroundColor = [UIColor clearColor];
    self.horizontalScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, 320, 420)];
    self.horizontalScroll.pagingEnabled=YES;
    
    
    self.horizontalScroll.contentSize = CGSizeMake(320 * myCardsList.count, 420);
    self.horizontalScroll.scrollEnabled = YES;
    self.horizontalScroll.delegate=self;
    [self.horizontalScroll setShowsHorizontalScrollIndicator:YES];
    

  
    
    
    [self.view addSubview:self.horizontalScroll];
    
    
    
    for (NSUInteger i=0; i<myCardsList.count; i++) {
        
        XYZFlashcard *flashcard = [myCardsList objectAtIndex:i];
        
        XYZFlashcardFront *front = [[XYZFlashcardFront alloc] initWithQuestion:flashcard.question withThumbsUp:flashcard.thumbsUp andThumbsDown:flashcard.thumbsDown isAddedToFavourites:flashcard.addedToFavourites withFrame:CGRectMake(self.horizontalScroll.frame.size.width*i, 65, 320, 420)];
        
        front.frontCoverButton.tag = i;
        [front.frontCoverButton addTarget:self action:@selector(flipCardToBackAtPos:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.horizontalScroll addSubview:front];
        
        
        
    }
    
    
}

-(void)flipCardToBackAtPos:(UIButton *)sender {
    
    

    XYZFlashcard *flashcard = [myCardsList objectAtIndex:sender.tag];
    
    XYZFlashcardBack *back = [[XYZFlashcardBack alloc] initWithAnswer:flashcard.answer withThumbsUp:flashcard.thumbsUp andThumbsDown:flashcard.thumbsDown isAddedToFavourites:flashcard.addedToFavourites withFrame:CGRectMake(self.horizontalScroll.frame.size.width*sender.tag, 65, 320, 420)];
    back.backCoverButton.tag=sender.tag;
    
    [back.backCoverButton addTarget:self action:@selector(flipCardToFrontAtPos:) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView transitionFromView:[self.horizontalScroll.subviews objectAtIndex:sender.tag] toView:back duration:1.0f options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        
            [self.horizontalScroll insertSubview:back atIndex:sender.tag];


        
    }];
    

    
    
    
    
}

-(void) flipCardToFrontAtPos:(UIButton *)sender {

    
    XYZFlashcard *flashcard = [myCardsList objectAtIndex:sender.tag];
    
    XYZFlashcardFront *front = [[XYZFlashcardFront alloc] initWithQuestion:flashcard.question withThumbsUp:flashcard.thumbsUp andThumbsDown:flashcard.thumbsDown isAddedToFavourites:flashcard.addedToFavourites withFrame:CGRectMake(self.horizontalScroll.frame.size.width*sender.tag, 65, 320, 420)];
    front.frontCoverButton.tag=sender.tag;
    
    [front.frontCoverButton addTarget:self action:@selector(flipCardToBackAtPos:) forControlEvents:UIControlEventTouchUpInside];
    
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

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    long pos = [self findIndexOfCurrentCardInFocus];
    
    if(pos>myCardsList.count)
    {
        return;
    }
    
    if([[myCardsList objectAtIndex:pos] addedToFavourites])
    {
        [self.favouriteButton setImage:[UIImage imageNamed:@"favouriteSelected.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.favouriteButton setImage:[UIImage imageNamed:@"favouriteNotSelected.png"] forState:UIControlStateNormal];
    }
    
    self.cardNumber.text = [NSString stringWithFormat:@"%ld of %ld",pos+1,(unsigned long)myCardsList.count];
    
    
    
}

- (void) loadMyCardList
{
        myCardsList = [[NSMutableArray alloc] init];
    
    //instead card data list from the data base
    for (int i = 0; i<10; i++) {
        
        XYZFlashcard *flashcard = [[XYZFlashcard alloc] init];
        flashcard.flashcardID = i+1;
        flashcard.question = [NSString stringWithFormat:@"your question/title goes here %d",flashcard.flashcardID];
        flashcard.answer = [NSString stringWithFormat:@"here is your answer, it should be short and precise %d", flashcard.flashcardID];
        flashcard.thumbsUp = 49;
        flashcard.thumbsDown = 76;
        flashcard.addedToFavourites=NO;
        
        [myCardsList addObject:flashcard];
    }
    
    
    
}

- (long) findIndexOfCurrentCardInFocus
{
    
    long pos= lroundf(self.horizontalScroll.contentOffset.x/self.horizontalScroll.frame.size.width);
    return pos;
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
    
    
    long pos = [self findIndexOfCurrentCardInFocus];
    
    if([[myCardsList objectAtIndex:pos] addedToFavourites])
    {
        [self.favouriteButton setImage:[UIImage imageNamed:@"favouriteNotSelected.png"] forState:UIControlStateNormal];
        XYZFlashcard *flashcard = [myCardsList objectAtIndex:pos];
        flashcard.addedToFavourites = NO;
    }
    else
    {
        [self.favouriteButton setImage:[UIImage imageNamed:@"favouriteSelected.png"] forState:UIControlStateNormal];
        XYZFlashcard *flashcard = [myCardsList objectAtIndex:pos];
        flashcard.addedToFavourites = YES
        ;
    }
    

    
    
    
}
@end
