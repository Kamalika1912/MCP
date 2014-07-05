//
//  XYZFlashcardBack.m
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 24/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import "XYZFlashcardBack.h"
#import "XYZFlashcard.h"

@implementation XYZFlashcardBack

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
           
    }
    return self;
}

-(id) initWithFlashcard:(XYZFlashcard *)card withFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        self.backCoverButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.backCoverButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.backCoverButton.layer.backgroundColor = [UIColor yellowColor].CGColor;
        self.backCoverButton.layer.borderWidth = 2.0;
        self.backCoverButton.frame = CGRectMake(20, 10, 280, 330);
        //self.preview.backgroundColor = [UIColor blueColor];
        self.backCoverButton.layer.cornerRadius = 5.0;
        [self.backCoverButton setTitle:card[@"answer"] forState:UIControlStateNormal];
        self.backCoverButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.backCoverButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.backCoverButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.backCoverButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
        [self.backCoverButton setTitleEdgeInsets:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)]; // PADDING

        [self addSubview:self.backCoverButton];
        
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
