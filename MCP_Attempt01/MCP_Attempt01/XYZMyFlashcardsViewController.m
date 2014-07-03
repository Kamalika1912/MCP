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
   
    // ############## LOAD CARD DATA - Load the course list and the whole cards present on my decks
    // load locally the whole list of cards
    NSError *error;
    NSString *path;
    // STORE
    path = [[NSBundle mainBundle] pathForResource:@"MyCards" ofType:@"json"];
    myCards = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:&error];
    if (error) NSLog(@"JSONObjectWithData error loading CARDS: %@", error);
    // COURSES
    path = [[NSBundle mainBundle] pathForResource:@"Courses" ofType:@"json"];
    courseList = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:&error];
    if (error) NSLog(@"JSONObjectWithData error loading COURSES: %@", error);
    
    
    // ############# LOAD LOCAL SAVED DATA (previously selected course and such)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // load the course from the user defaults, if none, then select the first course in the courses array
    selectedCourseString = ([defaults stringForKey:@"selectedCourse"]) != nil ? [defaults stringForKey:@"selectedCourse"] : courseList[0][@"title"];
    selectedCourseRowInPicker= [defaults integerForKey:@"selectedCourseRowInPicker"];
    
    // set the course title in the fake dropdown button
    [self.selectCourseButton setTitle:selectedCourseString forState:UIControlStateNormal];
    
    
    
    //LOAD THE DATA IN THE TABLE ARRAY
    filterdLectureList = [self loadLectureListForCourse:selectedCourseString ];

    
    
    
    
    
    
    
    
    
    //  self.view.backgroundColor = [UIColor clearColor ];
    // Do any additional setup after loading the view.
    //  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    selectedCourse=0;
    [self hideColorPickerView:YES];
    self.coursePickerView.layer.cornerRadius = 5.0;
    [self.coursePickerView setAlpha:0];
    [self.coursePickerViewBorder setAlpha:0];
    self.navigationController.navigationBarHidden = YES;
    
    
    
    [self loadCourseList];
    self.coursePicker.dataSource = self;
    self.coursePicker.delegate = self;
    self.filteredTableView.dataSource = self;
    self.filteredTableView.delegate = self;
    
    
    
}





// return a list of Topics (not numbered lectures anymore) for wich there are card available for the specified course
-(NSMutableArray *) loadLectureListForCourse:(NSString *)course {
    // filter all the cards by course
    NSArray *filteredCardsByCourse = [myCards filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(course == %@)", course]];
    // now create the list available topic for that course
    NSMutableArray *lectureList = [NSMutableArray array];
    for (NSDictionary *card in filteredCardsByCourse) {
        // if not already inserted in the list, insert the topic
        NSString *lecture = card[@"title"];
        if(![lectureList containsObject:lecture]) {
            [lectureList addObject:lecture];
        }
    }
    return lectureList;
}





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
        lectureCell.backgroundColor = [UIColor clearColor];
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
        tagCell.backgroundColor= [UIColor clearColor];
        
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


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"startStudying" sender:self];
    
}




//- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    NSIndexPath *selectedRowIndex = [self.filteredTableView indexPathForSelectedRow];
//    NSString *selectedItem;
//    
//    
//         selectedItem = [filterdLectureList objectAtIndex: selectedRowIndex.row];
//    }
//    else
//    {
//        selectedItem = [filteredTagList objectAtIndex: selectedRowIndex.row];
//    }
//    
//}
//




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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
