//
//  XYZCreateCardViewController.m
//  MCP_Attempt01
//
//  Created by MCP 2014 on 26/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import "XYZCreateCardViewController.h"
#import "XYZFlashcard.h"
#import "XYZFlashcardFront.h"
#import "XYZFlashcardBack.h"
#import "XYZFlipPreviewViewController.h"

@interface XYZCreateCardViewController ()

@end

@implementation XYZCreateCardViewController
//@synthesize QuestionTextView, AnswerTextView, TagTextView;
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
//    self.view.backgroundColor = [UIColor clearColor ];
}

-(void)flipCardToBackAtPos:(UIButton *)sender {
    
    XYZFlashcard *flashcard;
    
      //   back.backCoverButton.tag=sender.tag;
    
    //[back.backCoverButton addTarget:self action:@selector(flipCardToFrontAtPos:) forControlEvents:UIControlEventTouchUpInside];
    
    //[UIView transitionFromView:[self.horizontalScroll.subviews objectAtIndex:sender.tag] toView:back duration:1.0f options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        
    //}];
    
}

-(void) flipCardToFrontAtPos:(UIButton *)sender {
    
    
    XYZFlashcard *flashcard ;
    
   // XYZFlashcardFront *front = [[XYZFlashcardFront alloc] initWithQuestion:flashcard.question withThumbsUp:flashcard.thumbsUp andThumbsDown:flashcard.thumbsDown isAddedToFavourites:flashcard.addedToFavourites withFrame:CGRectMake(self.horizontalScroll.frame.size.width*sender.tag, 65, 320, 420)];
  //  front.frontCoverButton.tag=sender.tag;
    
    //[front.frontCoverButton addTarget:self action:@selector(flipCardToBackAtPos:) forControlEvents:UIControlEventTouchUpInside];
    
  //  [UIView transitionFromView:sender.superview toView:front duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        
    //}];
    
    
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self isMovingFromParentViewController]) {
        
        //this is done to remove the navigation bar from the parent screen as it has the drop down and opposite for the tab bar
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.tabBarController.tabBar.hidden = NO;
        
        
    }
}
-(IBAction)CheckFields:(id)sender
{
    if([answerField.text isEqualToString:@""] || [questionField.text isEqualToString:@""] || [labelField.text isEqualToString:@""] )
    {
        UIAlertView *messageAllert =[[UIAlertView alloc]initWithTitle:@"Failed to Preview" message:@"Fill all the info" delegate:nil    cancelButtonTitle: @"OK" otherButtonTitles: nil];
        [messageAllert show];
    }
    
    else{
        
               [self performSegueWithIdentifier:@"previewCard" sender:self];

    }
}
/*
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([answerField.text isEqualToString:@""] || [questionField.text isEqualToString:@""] || [labelField.text isEqualToString:@""] )
    {
        UIAlertView *messageAllert =[[UIAlertView alloc]initWithTitle:@"Failed to Preview" message:@"Fill all the info" delegate:nil    cancelButtonTitle: @"OK" otherButtonTitles: nil];
        [messageAllert show];
    }
    
    if ([segue.identifier isEqualToString:@"createSegue"])
    {
        
        NSString *question= questionField.text;
        NSString *answer=answerField.text;
        NSString *tag=labelField.text;
        XYZFlipPreviewViewController *destController= segue.destinationViewController ;
        destController.question= question;
        destController.answer=answer;
        destController.tag=tag;
    }

    
}*/
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *question= questionField.text;
    NSString *answer=answerField.text;
    NSString *tag=labelField.text;
    XYZFlipPreviewViewController *destController= segue.destinationViewController ;
    destController.question= question;
    destController.answer=answer;
    destController.tag=tag;
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

- (IBAction)TextFieldDismiss:(id)sender {
    [labelField resignFirstResponder];
    
}

- (IBAction)QuestionDismiss:(id)sender {
    [questionField resignFirstResponder];
}

- (IBAction)AnswerDismiss:(id)sender {
    [answerField resignFirstResponder];
}
@end
