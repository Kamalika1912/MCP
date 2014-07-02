//
//  StoreViewController.m
//  FLIP
//
//  Created by Giorgio Pretto on 6/25/14.
//  Copyright (c) 2014 MCP 2014. All rights reserved.
//

#import "StoreViewController.h"

@interface StoreViewController ()

//private utility methods

// given an array of cards, extract a list of all available lectures, no duplicates, ordered asc
- (NSArray *) getAvailableLectureListFromCards:(NSArray *)CardsList;

@end

@implementation StoreViewController

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
    
    // ## LOAD THE DATA FROM THE STORE
    
    // load the FAKE store from the file
    NSString *storePath = [[NSBundle mainBundle] pathForResource:@"Store" ofType:@"json"];
    // parse it and load it in an array
    NSError *error;
    _storeCards = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:storePath] options:NSJSONReadingMutableContainers error:&error];
    // if error just log it for  now and do not manage it
    if (error)
        NSLog(@"JSONObjectWithData error: %@", error);
    
    // ## END DATA LOADING
    
    // ## PARSE DATA
    // use the cards from the store to already get all available courses to be studied
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


// ## TABLE VIEW MANAGEMENT METHOD

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_storeCards count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lectureCell" forIndexPath:indexPath];
    
    NSString *question = _storeCards[indexPath.row][@"question"];
    
    // set the question
    ((UILabel *)[cell viewWithTag:1]).text = question;
    
    
    
    
    return cell;
}



// ##### PICKER MANAGEMENT METHODS

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _storeCards;
}







// ## STANDARD iOS METHOD

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showCoursePicker:(UIButton *)sender {
}
@end
