//
//  XYZMyFlashcardsViewController.h
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 14/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZMyFlashcardsViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDelegate,UITableViewDataSource>


{
    NSMutableArray *courseList;
    NSMutableArray *filterdLectureList;
    NSMutableArray *myCards;
    NSInteger selectedCourseRowInPicker;
    NSString *selectedCourseString;
}


@property (weak, nonatomic) IBOutlet UIPickerView *coursePicker;
@property (weak, nonatomic) IBOutlet UIButton *selectCourseButton;
@property (weak, nonatomic) IBOutlet UIView *coursePickerView;
@property (weak, nonatomic) IBOutlet UIView *coursePickerViewBorder;
@property (weak, nonatomic) IBOutlet UIButton *done;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UITableView *filteredTableView;



- (IBAction)selectCourseButtonTapped:(id)sender;
- (IBAction)doneButtonTapped:(id)sender;
- (IBAction)cancelButtonTapped:(id)sender;



@end
