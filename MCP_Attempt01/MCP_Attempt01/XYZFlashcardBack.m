//
//  XYZFlashcardBack.m
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 24/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import "XYZFlashcardBack.h"

@implementation XYZFlashcardBack

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
           
    }
    return self;
}

-(id) initWithAnswer: (NSString *)answer withThumbsUp:(NSInteger)thumbsUp andThumbsDown:(NSInteger)thumbsDown isAddedToFavourites:(BOOL)addedToFavourites withFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        self.backCoverButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.backCoverButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.backCoverButton.layer.borderWidth = 1.0;
        self.backCoverButton.frame = CGRectMake(20, 10, 280, 330);
        //self.preview.backgroundColor = [UIColor blueColor];
        self.backCoverButton.layer.cornerRadius = 5.0;
        [self.backCoverButton setTitle:answer forState:UIControlStateNormal];
        self.backCoverButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.backCoverButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.backCoverButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.backCoverButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:self.backCoverButton];
        
        
        
        self.thumbsDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 21, 28, 27)];
        UIColor *color2 = [UIColor colorWithPatternImage:[UIImage imageNamed:@"thumbs_down.jpg"]];
        self.thumbsDownLabel.backgroundColor = color2;
        [self addSubview:self.thumbsDownLabel];
        self.thumbsDownLabel.userInteractionEnabled=YES;
        
        
        self.thumbsUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 15, 28, 27)];
        UIColor *color1 = [UIColor colorWithPatternImage:[UIImage imageNamed:@"thumbs_up.jpg"]];
        self.thumbsUpLabel.backgroundColor = color1;
        [self addSubview:self.thumbsUpLabel];
        
        
        self.thumbsDownLabel.userInteractionEnabled=YES;
        UITapGestureRecognizer* downGesture = [[UITapGestureRecognizer alloc]       initWithTarget:self action:@selector(thumbsDownPressed:)];
        [self.thumbsDownLabel setUserInteractionEnabled:YES];
        [self.thumbsDownLabel addGestureRecognizer:downGesture];
        
        UITapGestureRecognizer* upGesture = [[UITapGestureRecognizer alloc]       initWithTarget:self action:@selector(thumbsUpPressed:)];
        [self.thumbsUpLabel setUserInteractionEnabled:YES];
        [self.thumbsUpLabel addGestureRecognizer:upGesture];
        
        
        self.redLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 19, 35, 25)];
        self.redLabel.textColor = [UIColor redColor];
        [self.redLabel setFont:[UIFont systemFontOfSize:19]];
        self.redLabel.text = [NSString stringWithFormat:@"%i",thumbsDown];
        self.redLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.redLabel];
        
        self.greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(255, 19, 35, 25)];
        self.greenLabel.textColor = [UIColor greenColor];
        [self.greenLabel setFont:[UIFont systemFontOfSize:19]];
        self.greenLabel.text = [NSString stringWithFormat:@"%i",thumbsUp];;
        self.greenLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.greenLabel];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void) thumbsDownPressed:(UITapGestureRecognizer *)gestureRecognizer
{
    self.thumbsDownLabel.shadowColor=[UIColor blueColor];
}

-(void) thumbsUpPressed:(UITapGestureRecognizer *)gestureRecognizer
{
    
}
@end
