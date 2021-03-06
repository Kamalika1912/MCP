//
//  XYZFlashcardFront.m
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 24/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import "XYZFlashcardFront.h"
#import "XYZFlashcard.h"
#import <QuartzCore/QuartzCore.h>



@implementation XYZFlashcardFront

-(id) initWithFlashcard:(XYZFlashcard*)card withFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        self.frontCoverButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.frontCoverButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.frontCoverButton.layer.backgroundColor = [UIColor yellowColor].CGColor;
        self.frontCoverButton.layer.borderWidth = 2.0;
        self.frontCoverButton.frame = CGRectMake(20, 10, 280, 330);
        //self.preview.backgroundColor = [UIColor blueColor];
        self.frontCoverButton.layer.cornerRadius = 5.0;
        [self.frontCoverButton setTitle:card[@"question"] forState:UIControlStateNormal];
        self.frontCoverButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.frontCoverButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.frontCoverButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.frontCoverButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
        [self.frontCoverButton setTitleEdgeInsets:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)]; // PADDING

        [self addSubview:self.frontCoverButton];
        
        
        
        self.thumbsDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 21, 28, 27)];
        UIColor *color2 = [UIColor colorWithPatternImage:[UIImage imageNamed:@"thumbs_down.png"]];
        self.thumbsDownLabel.backgroundColor = color2;
        [self addSubview:self.thumbsDownLabel];
        
        
        self.thumbsUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 15, 28, 27)];
        UIColor *color1 = [UIColor colorWithPatternImage:[UIImage imageNamed:@"thumbs_up.png"]];
        self.thumbsUpLabel.backgroundColor = color1;
        [self addSubview:self.thumbsUpLabel];
        self.thumbsUpLabel.opaque=YES;
        self.thumbsUpLabel.userInteractionEnabled=YES;
        
        
        self.thumbsDownLabel.userInteractionEnabled=YES;
        UITapGestureRecognizer* downGesture = [[UITapGestureRecognizer alloc]       initWithTarget:self action:@selector(thumbsDownPressed:)];
        [self.thumbsDownLabel setUserInteractionEnabled:YES];
        [self.thumbsDownLabel addGestureRecognizer:downGesture];
        
        UITapGestureRecognizer* upGesture = [[UITapGestureRecognizer alloc]       initWithTarget:self action:@selector(thumbsUpPressed:)];
        [self.thumbsUpLabel setUserInteractionEnabled:YES];
        [self.thumbsUpLabel addGestureRecognizer:upGesture];

        
        
        
        self.redLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 19, 35, 25)];
   
        [self.redLabel setFont:[UIFont systemFontOfSize:19]];
        self.redLabel.text = card[@"downVote"];
        self.redLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.redLabel];
        
        self.greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(255, 19, 35, 25)];
        
        [self.greenLabel setFont:[UIFont systemFontOfSize:19]];
        self.greenLabel.text = card[@"upVote"];
        self.greenLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.greenLabel];
    }
    return self;
}
//initiations for create and edit Card

-(id) initWithFlashcardSimple:(XYZFlashcard*)card withFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        self.frontCoverButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.frontCoverButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.frontCoverButton.layer.backgroundColor = [UIColor yellowColor].CGColor;
        self.frontCoverButton.layer.borderWidth = 2.0;
        self.frontCoverButton.frame = CGRectMake(20, 10, 280, 330);
        //self.preview.backgroundColor = [UIColor blueColor];
        self.frontCoverButton.layer.cornerRadius = 5.0;
        [self.frontCoverButton setTitle:card[@"question"] forState:UIControlStateNormal];
        self.frontCoverButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.frontCoverButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.frontCoverButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.frontCoverButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
        [self.frontCoverButton setTitleEdgeInsets:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)]; // PADDING
        
        [self addSubview:self.frontCoverButton];
        
    }
    return self;
}


-(id) initWithFlashcardForCreate:(XYZFlashcard*)card withFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code        
        
        self.courseLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 01, 85, 85)];
        
        [self.courseLabel setFont:[UIFont systemFontOfSize:19]];
        self.courseLabel.text = @"Course:";
        self.courseLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.courseLabel];
        
        self.lecLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 38, 85, 85)];
        
        [self.lecLabel setFont:[UIFont systemFontOfSize:19]];
        self.lecLabel.text = @"Subject:";
        self.lecLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.lecLabel];
        
//        self.frontCoverButton.
        self.frontCoverButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.frontCoverButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.frontCoverButton.layer.backgroundColor = [UIColor yellowColor].CGColor;
        self.frontCoverButton.layer.borderWidth = 2.0;
        self.frontCoverButton.frame = CGRectMake(20, 100, 280, 250);
        //self.preview.backgroundColor = [UIColor blueColor];
        self.frontCoverButton.layer.cornerRadius = 5.0;
        [self.frontCoverButton setTitle:@"Long press to add question" forState:UIControlStateNormal];
        self.frontCoverButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.frontCoverButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.frontCoverButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.frontCoverButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.frontCoverButton setTitleEdgeInsets:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)]; // PADDING
        
        [self addSubview:self.frontCoverButton];
        
    }
    return self;
}




-(void) thumbsDownPressed:(UITapGestureRecognizer *)gestureRecognizer
{
    //card[@"downVote"]--; checking wheather the user has voted...decrease
    
    self.thumbsDownLabel.layer.shadowRadius = 4.0f;
    self.thumbsDownLabel.layer.shadowOpacity = .9;
    self.thumbsDownLabel.layer.shadowOffset = CGSizeZero;
    self.thumbsDownLabel.layer.masksToBounds = NO;
}

-(void) thumbsUpPressed:(UITapGestureRecognizer *)gestureRecognizer
{
 //card[@"downVote"]++;
    self.thumbsUpLabel.layer.shadowRadius = 4.0f;
    self.thumbsUpLabel.layer.shadowOpacity = .9;
    self.thumbsUpLabel.layer.shadowOffset = CGSizeZero;
    self.thumbsUpLabel.layer.masksToBounds = NO;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end
