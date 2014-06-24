//
//  XYZFlashcardBack.h
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 24/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZFlashcardBack : UIView

@property (strong,nonatomic) UIButton *backCoverButton;
@property (strong,nonatomic) UILabel *redLabel;
@property (strong,nonatomic) UILabel *greenLabel;

-(id) initWithAnswer: (NSString *)answer withThumbsUp:(NSInteger)thumbsUp andThumbsDown:(NSInteger)thumbsDown isAddedToFavourites:(BOOL)addedToFavourites withFrame:(CGRect)frame;

@end