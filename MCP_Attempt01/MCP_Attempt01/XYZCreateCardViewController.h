//
//  XYZCreateCardViewController.h
//  MCP_Attempt01
//
//  Created by MCP 2014 on 26/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZCreateCardViewController : UIViewController {

    IBOutlet UITextField *answerField;
    IBOutlet UITextField *labelField;
    IBOutlet UITextField *questionField;
}
- (IBAction)TextFieldDismiss:(id)sender;
- (IBAction)QuestionDismiss:(id)sender;
- (IBAction)AnswerDismiss:(id)sender;

@end
