//
//  XYZCardPreview.h
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 22/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZFlashcard.h"

@interface XYZCardPreview : UIView
{
    XYZFlashcard *flashcardPreview;
}

@property (strong,nonatomic) UIButton *preview;
@property (strong,nonatomic) UILabel *redLabel;
@property (strong,nonatomic) UILabel *greenLabel;
@property (strong,nonatomic) UIButton *buy;

@property (strong,nonatomic) UILabel *thumbsUpLabel;
@property (strong,nonatomic) UILabel *thumbsDownLabel;


- (id) initWithFlashcard:(XYZFlashcard *)flashcard andFrame: (CGRect)frame;

@end
