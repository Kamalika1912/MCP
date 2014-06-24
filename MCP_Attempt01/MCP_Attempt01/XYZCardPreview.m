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

- (id) initWithFlashcard:(XYZFlashcard *)flashcard andFrame: (CGRect)frame
{
    flashcardPreview = flashcard;
    return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        

        
        self.preview = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.preview.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.preview.layer.borderWidth = 1.0;
        self.preview.frame = CGRectMake(10, 10, 160, 200);
        //self.preview.backgroundColor = [UIColor blueColor];
        self.preview.layer.cornerRadius = 5.0;
        [self.preview setTitle:@"Flashcards are awesome to study and it comes in pretty handy" forState:UIControlStateNormal];
        self.preview.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.preview setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.preview.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.preview.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:self.preview];
        
        
        self.redLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 20, 100, 50)];
        self.redLabel.textColor = [UIColor redColor];
        [self.redLabel setFont:[UIFont systemFontOfSize:45]];
        self.redLabel.text = @"-45";
        self.redLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.redLabel];
        
        self.greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 70, 100, 50)];
        self.greenLabel.textColor = [UIColor greenColor];
        [self.greenLabel setFont:[UIFont systemFontOfSize:45]];
        self.greenLabel.text = @"+79";
        self.greenLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.greenLabel];
        
        self.buy = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.buy.frame = CGRectMake(190, 130, 100, 65);
        self.buy.backgroundColor = [UIColor colorWithRed:0.0 green:0.6 blue:1.0 alpha:1.0];
        self.buy.layer.cornerRadius = 5.0;
        [self.buy setTitle:@"Buy" forState:UIControlStateNormal];
        [self.buy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.buy.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.buy.titleLabel setFont:[UIFont systemFontOfSize:45]];
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
