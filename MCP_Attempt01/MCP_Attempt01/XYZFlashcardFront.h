//
//  XYZFlashcardFront.h
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 24/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZFlashcard.h"

@interface XYZFlashcardFront : UIView

@property (strong,nonatomic) UIButton *frontCoverButton;
@property (strong,nonatomic) UILabel *redLabel;
@property (strong,nonatomic) UILabel *greenLabel;

@property (strong,nonatomic) UILabel *courseLabel;
@property (strong,nonatomic) UILabel *lecLabel;



@property (strong,nonatomic) UILabel *thumbsUpLabel;
@property (strong,nonatomic) UILabel *thumbsDownLabel;

-(id) initWithFlashcard:(XYZFlashcard *)card withFrame:(CGRect)frame;
-(id) initWithFlashcardSimple:(XYZFlashcard*)card withFrame:(CGRect)frame;
-(id) initWithFlashcardForCreate:(XYZFlashcard*)card withFrame:(CGRect)frame;
-(void) thumbsDownPressed:(UITapGestureRecognizer *)gestureRecognizer;
-(void) thumbsUpPressed:(UITapGestureRecognizer *)gestureRecognizer;
@end
