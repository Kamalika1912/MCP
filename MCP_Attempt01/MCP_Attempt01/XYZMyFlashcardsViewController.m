//
//  XYZMyFlashcardsViewController.m
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 14/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import "XYZMyFlashcardsViewController.h"
#import "XYZStartStudyingViewController.h"
#import "QuartzCore/QuartzCore.h"

@interface XYZMyFlashcardsViewController ()

@end

@implementation XYZMyFlashcardsViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    selectedCourse=0;
    [self hideColorPickerView:YES];
    self.coursePickerView.layer.cornerRadius = 5.0;
    [self.coursePickerView setAlpha:0];
    [self.coursePickerViewBorder setAlpha:0];
    self.navigationController.navigationBarHidden = YES;
    
    
    
    [self loadCourseList];
    self.coursePicker.dataSource = self;
    self.coursePicker.delegate =self;
    self.filteredTableView.dataSource = self;
    self.filteredTableView.delegate = self;
    
    
    [self.selectFilter addTarget:self action:@selector(changeFilterAndReloadData) forControlEvents:UIControlEventValueChanged];
    loadLectureList = YES;
    [self loadFilterdLectureList];
    
    
}

-(void) loadCourseList {
    
    courseList = [NSMutableArray arrayWithObjects:@"Designing Interactive Systems 1",@"Designing Interactive Systems 2",@"Media Computing Project",@"Internet Of Things",@"Current topics in HCI",@"Post Desktop User Interfaces", nil];
    
    
}

-(void) loadFilterdLectureList {
    
    filterdLectureList = [NSMutableArray arrayWithObjects:@"Lecture 1",@"Lecture 2",@"Lecture 3",@"Lecture 4",@"Lecture 5",@"Lecture 6",@"Lecture 7",@"Lecture 8", nil];
    
}

-(void) loadFilteredTagList {
    
    filteredTagList = [NSMutableArray arrayWithObjects:@"DIA cycle",@"CMN Model",@"Seven Stages",@"Afforandance",@"Constraints",@"Visibility", nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return courseList.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return courseList[row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    
    selectedCourse = row;
    
}

-(UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label = (id)view;
    label = [[UILabel alloc] init];
    label.font= [UIFont systemFontOfSize:16];
    
    
    label.text= [courseList objectAtIndex:row];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(loadLectureList)
    {
        return [filterdLectureList count];
    }
    else
    {
        return [filteredTagList count];
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(loadLectureList)
    {
        static NSString *cellIdentifier = @"Lectures";
        
        UITableViewCell *lectureCell = [tableView dequeueReusableCellWithIdentifier:
                                        cellIdentifier];
        if (lectureCell == nil) {
            lectureCell = [[UITableViewCell alloc]initWithStyle:
                           UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        NSString *stringForCell;
        
        stringForCell= [filterdLectureList objectAtIndex:indexPath.row];
        
        [lectureCell.textLabel setText:stringForCell];
        return lectureCell;
    }
    else
    {
        static NSString *cellIdentifierTags = @"Tags";
        
        UITableViewCell *tagCell = [tableView dequeueReusableCellWithIdentifier:
                                    cellIdentifierTags];
        if (tagCell == nil) {
            tagCell = [[UITableViewCell alloc]initWithStyle:
                       UITableViewCellStyleDefault reuseIdentifier:cellIdentifierTags];
        }
        
        NSString *stringForTags;
        
        stringForTags= [filteredTagList objectAtIndex:indexPath.row];
        
        [tagCell.textLabel setText:stringForTags];
        return tagCell;
    }
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (void) changeFilterAndReloadData {
    
    if (loadLectureList) {
        
        [self loadFilteredTagList];
        loadLectureList = NO;
        [self.filteredTableView reloadData];
        
        
    } else {
        
        [self loadFilterdLectureList];
        loadLectureList = YES;
        [self.filteredTableView reloadData];
        
    }
    
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"startStudying" sender:self];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *selectedRowIndex = [self.filteredTableView indexPathForSelectedRow];
    NSString *selectedItem;
    
    
    if(loadLectureList)
    {
        selectedItem = [filterdLectureList objectAtIndex: selectedRowIndex.row];
    }
    else
    {
        selectedItem = [filteredTagList objectAtIndex: selectedRowIndex.row];
    }
    
    //buyCards.loadLectureList = YES;
    //buyCards.selectedRow = selectedItem;
    
    
}





- (IBAction)selectCourseButtonTapped:(id)sender {
    
    [self hideColorPickerView:NO];
    [self.coursePickerView setBackgroundColor:[UIColor whiteColor]];
    
    
    if ([self.selectCourseButton.titleLabel.text isEqualToString:@"Select Course"]) {
        [self.coursePicker selectRow:selectedCourse inComponent:0 animated:YES];
    }
    else {
        
        
        [self.coursePicker selectRow:selectedCourse inComponent:0 animated:YES];
        
    }
    
    [self.filteredTableView deselectRowAtIndexPath:[self.filteredTableView indexPathForSelectedRow] animated:YES];
    
    
    
}



- (IBAction)filterValueChanged:(id)sender {
}

- (IBAction)doneButtonTapped:(id)sender {
    
    [self hideColorPickerView:YES];
    [self.selectCourseButton setTitle:[courseList objectAtIndex:selectedCourse] forState:UIControlStateNormal];
    
    
}

- (IBAction)cancelButtonTapped:(id)sender {
    
    [self hideColorPickerView:YES];
    if (![self.selectCourseButton.titleLabel.text isEqualToString:@"Select Course"]) {
        selectedCourse = [courseList indexOfObject:self.selectCourseButton.titleLabel.text];
    }
    
}





-(void) hideColorPickerView:(BOOL)hidden{
    
    if(hidden) {
        
        [self.coursePickerView setAlpha:0];
        [self.coursePickerViewBorder setAlpha:0];
        [self.coursePickerViewBorder setHidden:YES];
        [self.coursePickerView setHidden:YES];
        [self.coursePicker setHidden:YES];
        self.done.hidden = YES;
        self.cancel.hidden = YES;
        self.tabBarController.tabBar.hidden=NO;
        
        
        
    }
    else {
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.75];
        [self.coursePickerView setAlpha:1];
        [self.coursePickerViewBorder setAlpha:1];
        [UIView commitAnimations];
        
        [self.coursePickerViewBorder setHidden:NO];
        [self.coursePickerView setHidden:NO];
        [self.coursePicker setHidden:NO];
        self.done.hidden = NO;
        self.cancel.hidden = NO;
        self.tabBarController.tabBar.hidden=YES;
        
        
    }
    
}



@end
