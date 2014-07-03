//
//  XYZStoreViewController.h
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 22/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZStoreViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDelegate,UITableViewDataSource>


{
    NSMutableArray *courseList;
    NSMutableArray *filterdLectureList;
    NSMutableArray *storeCards;
    NSInteger selectedCourseRowInPicker;
    NSString *selectedCourseString;    
}


@property (weak, nonatomic) IBOutlet UIPickerView *coursePicker;
@property (weak, nonatomic) IBOutlet UIButton *selectCourseButton;
@property (weak, nonatomic) IBOutlet UISwitch *selectFilter;
@property (weak, nonatomic) IBOutlet UIView *coursePickerView;
@property (weak, nonatomic) IBOutlet UIView *coursePickerViewBorder;
@property (weak, nonatomic) IBOutlet UIButton *done;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UITableView *filteredTableView;





- (IBAction)selectCourseButtonTapped:(id)sender;

- (IBAction)doneButtonTapped:(id)sender;
- (IBAction)cancelButtonTapped:(id)sender;



@end
