//
//  XYZFlashcardBack.h
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 24/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZFlashcard.h"

@interface XYZFlashcardBack : UIView

@property (strong,nonatomic) UIButton *backCoverButton;
@property (strong,nonatomic) UILabel *redLabel;
@property (strong,nonatomic) UILabel *greenLabel;

@property (strong,nonatomic) UILabel *courseLabel;
@property (strong,nonatomic) UILabel *lecLabel;


@property (strong,nonatomic) UILabel *thumbsUpLabel;
@property (strong,nonatomic) UILabel *thumbsDownLabel;

-(id) initWithFlashcardForCreate:(XYZFlashcard*)card withFrame:(CGRect)frame;
-(id) initWithFlashcard:(XYZFlashcard *)card withFrame:(CGRect)frame;
 

@end
