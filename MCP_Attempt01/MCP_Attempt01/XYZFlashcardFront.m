//
//  XYZFlashcardFront.m
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 24/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import "XYZFlashcardFront.h"

@implementation XYZFlashcardFront

-(id) initWithQuestion: (NSString *)question withThumbsUp:(NSInteger)thumbsUp andThumbsDown:(NSInteger)thumbsDown isAddedToFavourites:(BOOL)addedToFavourites withFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        self.frontCoverButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.frontCoverButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.frontCoverButton.layer.borderWidth = 1.0;
        self.frontCoverButton.frame = CGRectMake(20, 10, 280, 330);
        //self.preview.backgroundColor = [UIColor blueColor];
        self.frontCoverButton.layer.cornerRadius = 5.0;
        [self.frontCoverButton setTitle:question forState:UIControlStateNormal];
        self.frontCoverButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.frontCoverButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.frontCoverButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.frontCoverButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:self.frontCoverButton];
        
        
        self.redLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 15, 35, 25)];
        self.redLabel.textColor = [UIColor redColor];
        [self.redLabel setFont:[UIFont systemFontOfSize:17]];
        self.redLabel.text = [NSString stringWithFormat:@"+%i",thumbsDown];
        self.redLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.redLabel];
        
        self.greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 15, 35, 25)];
        self.greenLabel.textColor = [UIColor greenColor];
        [self.greenLabel setFont:[UIFont systemFontOfSize:17]];
        self.greenLabel.text = [NSString stringWithFormat:@"-%i",thumbsUp];;
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

@end
