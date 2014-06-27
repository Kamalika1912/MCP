//
//  XYZCreateCardViewController.h
//  MCP_Attempt01
//
//  Created by MCP 2014 on 26/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZCreateCardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *TagTextView;
@property (weak, nonatomic) IBOutlet UITextView *QuestionTextView;
@property (weak, nonatomic) IBOutlet UITextView *AnswerTextView;

- (IBAction)PreviewButtonPressed:(id)sender;

@end
