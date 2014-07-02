//
//  StoreViewController.h
//  FLIP
//
//  Created by Giorgio Pretto on 6/25/14.
//  Copyright (c) 2014 MCP 2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreViewController : UIViewController<UITableViewDataSource,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate>

// top right button to select the current course through a picker
@property (weak, nonatomic) IBOutlet UIButton *pickCourseButton;

// Array in which the cards from the store will be loaded
@property NSMutableArray *storeCards;


// METHODS

- (void)loadCourses;

- (IBAction)showCoursePicker:(UIButton *)sender;


@end
