//
//  XYZEditCardViewController.h
//  MCP_Attempt01
//
//  Created by MCP 2014 on 06/07/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZMyFlashcardsViewController.h"
#import "XYZFlashcard.h"
#import "XYZFlashcardFront.h"
#import "XYZFlashcardBack.h"


@interface XYZEditCardViewController : UIViewController<UIScrollViewDelegate>
@property (strong, nonatomic) NSString *answer;
@property (strong, nonatomic) NSString *question;
@property (strong, nonatomic) UIScrollView *horizontalScroll;
@property (strong,nonatomic) XYZFlashcard *flashCard;

-(void) tapToEdit:(UITapGestureRecognizer *)gestureRecognizer;
@end
