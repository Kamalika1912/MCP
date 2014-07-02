//
//  XYZStoreViewController.m
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 22/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import "XYZStoreViewController.h"
#import "XYZBuyCardsViewController.h"
#import "QuartzCore/QuartzCore.h"

@interface XYZStoreViewController ()

@end

@implementation XYZStoreViewController


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
     self.view.backgroundColor = [UIColor clearColor ];    
    
 
    // ############## LOAD CARD DATA - Load the course list and the whole cards present on the Srore
    // load locally the whole list of cards
    NSError *error;
    NSString *path;
    // STORE
    path = [[NSBundle mainBundle] pathForResource:@"Store" ofType:@"json"];
    storeCards = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:&error];
    if (error) NSLog(@"JSONObjectWithData error loading CARDS: %@", error);
    // COURSES
    path = [[NSBundle mainBundle] pathForResource:@"Courses" ofType:@"json"];
    courseList = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:&error];
    if (error) NSLog(@"JSONObjectWithData error loading COURSES: %@", error);
    
    
    // ############# LOAD LOCAL SAVED DATA (previously selected course and such)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // load the course from the user defaults, if none, then select the first course in the courses array
    selectedCourseString = ([defaults stringForKey:@"selectedCourse"]) != nil ? [defaults stringForKey:@"selectedCourse"] : courseList[0][@"title"];
    
    
    
    
    
    selectedCourse=0;
    
    // programmatical preparation of dropdowmenu
    [self hideColorPickerView:YES];
    self.coursePickerView.layer.cornerRadius = 5.0;
    [self.coursePickerView setAlpha:0];
    [self.coursePickerViewBorder setAlpha:0];
    
    
    
    self.coursePicker.dataSource = self;
    self.coursePicker.delegate =self;
    self.filteredTableView.dataSource = self;
    self.filteredTableView.delegate = self;
    
    
//    [self.selectFilter addTarget:self action:@selector(changeFilterAndReloadData) forControlEvents:UIControlEventValueChanged];
//    loadLectureList = YES;
//    [self loadFilterdLectureList];
    
    self.navigationController.navigationBarHidden = YES;
    
    
}




// return an ascending ordererd list of lecture for wich there are card available for the specified course

-(NSArray *) loadLectureListForCourse:(NSString *)course {
    // filter all the cards by course
    NSArray *filteredCardsByCourse = [storeCards filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(course == %@)", course]];
    // now create the list available lecture for that course
    NSMutableArray *lectureList = [NSMutableArray array];
    for (NSDictionary *card in filteredCardsByCourse) {
        // if not already inserted in the list, insert the lecture
        NSString *lecture = card[@"lecture"];
        if(![lectureList containsObject:lecture]) {
            [lectureList addObject:lecture];
        }
    }
    
    
    
    
//    NSArray *sorted = [lectureList sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        if (obj1[@"lecture"] < obj2[@"lecture"]) return NSOrderedDescending;
//        else return NSOrderedAscending;
//    }];
    

    return [lectureList copy];
}

//-(void) loadFilteredTagList {
//    
//    filteredTagList = [NSMutableArray arrayWithObjects:@"DIA cycle",@"CMN Model",@"Seven Stages",@"Afforandance",@"Constraints",@"Visibility", nil];
//    
//}











/
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
    return courseList[row][@"title"];
}


// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    
    selectedCourse = row;
  
    // retrive the id of the course from the course object
    selectedCourseString = [courseList[row][@"title"] integerValue];
    
}

-(UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label = (id)view;
    label = [[UILabel alloc] init];
    label.font= [UIFont systemFontOfSize:16];
    
    
    label.text= [courseList objectAtIndex:row][@"title"];
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
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreCourseCell" forIndexPath:indexPath];
        
//        NSString *question = filterdLectureList[indexPath.row][@"id"];
        
        
        
        // set the question
        
        cell.textLabel.text = filterdLectureList[indexPath.row];
//        ((UILabel *)[cell viewWithTag:1]).text = question;
        // set the up/down vote star level (to be changed to whatever we want, just a quick example)
//        ((UILabel *)[cell viewWithTag:3]).text = @"@@@";
        
        
        
        return cell;
        
        
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

//- (void) changeFilterAndReloadData {
//    
////    if (loadLectureList) {
//    
//        [self loadFilteredTagList];
//        loadLectureList = NO;
//        [self.filteredTableView reloadData];
//        
//        
//    } else {
//        
//        [self loadFilterdLectureList];
//        loadLectureList = YES;
//        [self.filteredTableView reloadData];
//        
//    }
//    
//    
//}











- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSArray *filteredCardsByCourse = [storeCards filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(course == %@)", [NSString stringWithFormat:@"%d",(int)selectedCourseID]]];
//    NSUInteger row = [indexPath row];
//    
//    NSArray *filteredCards  = [filteredCardsByCourse filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(lecture == %@)", filterdLectureList[row]]];
//
    
    [self performSegueWithIdentifier:@"buyCards" sender:self];
    
}










- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *selectedRowIndex = [self.filteredTableView indexPathForSelectedRow];
    NSString *selectedItem;


    if(loadLectureList)
    {
        NSArray *filteredCardsByCourse = [storeCards filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(course == %@)", [NSString stringWithFormat:@"%d",(int)selectedCourseID]]];
//        NSUInteger row = [indexPath row];
        selectedItem = [filterdLectureList objectAtIndex: selectedRowIndex.row];
        NSArray *filteredCards  = [filteredCardsByCourse filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(lecture == %@)", selectedItem]];
        

        
        XYZBuyCardsViewController *targetVC = (XYZBuyCardsViewController*)segue.destinationViewController;
        targetVC.flashCardList= filteredCards;
        
        
    }
    else
    {
        selectedItem = [filteredTagList objectAtIndex: selectedRowIndex.row];
    }
    
    
//    NSLog(@"%@",@"Mah");
    
    
    //XYZBuyCardsViewController *buyCards = [segue destinationViewController];
    //buyCards.loadLectureList = YES;
    //buyCards.selectedRow = selectedItem;
    
    
}





- (IBAction)selectCourseButtonTapped:(id)sender {
    
    [self hideColorPickerView:NO];
    [self.coursePickerView setBackgroundColor:[UIColor whiteColor]];
    
    
    
    // Why the if? don't they do the same thing?
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
    [self.selectCourseButton setTitle:[courseList objectAtIndex:selectedCourse][@"title"] forState:UIControlStateNormal];
    
    [self loadFilterdLectureList];
    
    [self.filteredTableView reloadData];
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





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



// STANDARD STUFF

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
