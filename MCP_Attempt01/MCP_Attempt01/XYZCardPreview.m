//
//  XYZCardPreview.m
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 22/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import "XYZCardPreview.h"
#import "XYZFlashcard.h"

@implementation XYZCardPreview

- (id) initWithFlashcard:(XYZFlashcard *)flashcard andBought:(BOOL )b andFrame: (CGRect)frame
{
    _bought = b;
    flashcardPreview = flashcard;
    return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        
        
        self.preview = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.preview.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.preview.layer.backgroundColor = [UIColor yellowColor].CGColor;
        self.preview.layer.borderWidth = 2.0;
        self.preview.frame = CGRectMake(10, 10, 160, 200);
        //self.preview.backgroundColor = [UIColor blueColor];
        self.preview.layer.cornerRadius = 5.0;
        [self.preview setTitle:flashcardPreview[@"question"] forState:UIControlStateNormal];
        self.preview.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.preview setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.preview.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.preview.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [self addSubview:self.preview];
        
        
        self.redLabel = [[UILabel alloc] initWithFrame:CGRectMake(215, 75, 100, 50)];
        //self.redLabel.textColor = [UIColor redColor];

        [self.redLabel setFont:[UIFont systemFontOfSize:30]];
        self.redLabel.text = flashcardPreview[@"downVote"];
        self.redLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.redLabel];
        
        self.greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(215, 30, 100, 50)];
       // self.greenLabel.textColor = [UIColor greenColor];
        [self.greenLabel setFont:[UIFont systemFontOfSize:30]];
        self.greenLabel.text = flashcardPreview[@"upVote"];
        self.greenLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.greenLabel];
        
        self.thumbsDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(205, 91, 28, 27)];
        UIColor *color2 = [UIColor colorWithPatternImage:[UIImage imageNamed:@"thumbs_down.jpg"]];
        self.thumbsDownLabel.backgroundColor = color2;
        [self addSubview:self.thumbsDownLabel];
        
        
        self.thumbsUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(205, 38, 28, 27)];
        UIColor *color1 = [UIColor colorWithPatternImage:[UIImage imageNamed:@"thumbs_up.jpg"]];
        self.thumbsUpLabel.backgroundColor = color1;
        [self addSubview:self.thumbsUpLabel];
        
        
        self.buy = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.buy.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.buy.layer.borderWidth = 2.0;
        self.buy.frame = CGRectMake(200, 170, 100, 40);
        //self.preview.backgroundColor = [UIColor blueColor];
        self.buy.layer.cornerRadius = 5.0;
        [self.buy setTitleColor:[UIColor colorWithRed:0.0 green:0.6 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        self.buy.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.buy.titleLabel setFont:[UIFont systemFontOfSize:30]];
        
        if (_bought) {
            [self.buy setTitle:@"Bought" forState:UIControlStateNormal];
            [self.buy setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.buy.layer.borderColor = [UIColor grayColor].CGColor;
            self.buy.enabled = FALSE;
        } else {
            [self.buy setTitle:@"Buy" forState:UIControlStateNormal];
            [self.buy setTitleColor:[UIColor colorWithRed:0.0 green:0.6 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
            self.buy.layer.borderColor = [UIColor colorWithRed:0.0 green:0.6 blue:1.0 alpha:1.0].CGColor;
        }

        [self addSubview:self.buy];

        
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
