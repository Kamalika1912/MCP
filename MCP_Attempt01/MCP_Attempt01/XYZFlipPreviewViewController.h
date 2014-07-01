//
//  XYZFlipPreviewViewController.h
//  MCP_Attempt01
//
//  Created by MCP 2014 on 30/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZMyFlashcardsViewController.h"
#import "XYZFlashcard.h"
#import "XYZFlashcardFront.h"
#import "XYZFlashcardBack.h"

@interface XYZFlipPreviewViewController : UIViewController
{
    XYZFlashcardBack *backCard;
    XYZFlashcardFront *frontCard;
    XYZFlashcard *flashcard;
    UIScrollView *horizontalScroll;
}

@property (strong, nonatomic) IBOutlet UIButton *SubmitButton;
- (IBAction)SubmitCard:(id)sender;

@property (weak,nonatomic) IBOutlet UILabel *tagLabel;
@property (strong, nonatomic) NSString *question;
@property (strong, nonatomic) NSString *answer;
@property (strong, nonatomic) NSString *tag;



@end
