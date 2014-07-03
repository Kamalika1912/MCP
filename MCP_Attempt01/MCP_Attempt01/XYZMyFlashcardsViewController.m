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
 
    
    
    
    // some stuff
    [self hideColorPickerView:YES];
    self.coursePickerView.layer.cornerRadius = 5.0;
    [self.coursePickerView setAlpha:0];
    [self.coursePickerViewBorder setAlpha:0];
    self.navigationController.navigationBarHidden = YES;

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



//######## PICKER STUFF

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
    selectedCourseRowInPicker = row;
}

-(UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label = (id)view;
    label = [[UILabel alloc] init];
    label.font= [UIFont systemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    label.text= [courseList objectAtIndex:row];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

// show the picker
- (IBAction)selectCourseButtonTapped:(id)sender {
    [self hideColorPickerView:NO];
    [self.coursePickerView setBackgroundColor:[UIColor darkGrayColor]];
    [self.coursePicker selectRow:selectedCourseRowInPicker inComponent:0 animated:YES];
    [self.filteredTableView deselectRowAtIndexPath:[self.filteredTableView indexPathForSelectedRow] animated:YES];
}


- (IBAction)doneButtonTapped:(id)sender {
    
    [self hideColorPickerView:YES];
    [self.selectCourseButton setTitle:[courseList objectAtIndex:selectedCourseRowInPicker][@"title"] forState:UIControlStateNormal];
    
    filterdLectureList = [self loadLectureListForCourse:[courseList objectAtIndex:selectedCourseRowInPicker][@"title"]];
    
    [self.filteredTableView reloadData];
    
    // save the selected course for other tab use and future uses
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:selectedCourseString forKey:@"selectedCourse"];
    [defaults setInteger:selectedCourseRowInPicker forKey:@"selectedCourseRowInPicker"];
    [defaults synchronize];
}

- (IBAction)cancelButtonTapped:(id)sender {
    
    [self hideColorPickerView:YES];
    if (![self.selectCourseButton.titleLabel.text isEqualToString:@"Select Course"]) {
        selectedCourseRowInPicker = [courseList indexOfObject:self.selectCourseButton.titleLabel.text];
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









//#### TABLE VIEW STUFF

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [filterdLectureList count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topicCell" forIndexPath:indexPath];
    cell.textLabel.text = filterdLectureList[indexPath.row];
    return cell;
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








- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
