//
//  StoreViewController.m
//  FLIP
//
//  Created by Giorgio Pretto on 6/25/14.
//  Copyright (c) 2014 MCP 2014. All rights reserved.
//

#import "StoreViewController.h"

@interface StoreViewController ()

@end

@implementation StoreViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        NSLog(@"Ehm.. should be here");

        // Fake some json data response for now
        
        
        
        
//        for (NSMutableDictionary *dictionary in array)
//        {
//            NSString *arrayString = dictionary[@"array"];
//            if (arrayString)
//            {
//                NSData *data = [arrayString dataUsingEncoding:NSUTF8StringEncoding];
//                NSError *error = nil;
//                dictionary[@"array"] = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//                if (error)
//                    NSLog(@"JSONObjectWithData for array error: %@", error);
//            }
//        }
//        
        
        
        
        
        
        
        
    }
    return self;
}






- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //
    //DATA
    //
    
    // create a string with json defined data, as it would be returned by a server.
    NSString *storeCardsString = @"["
    "{\"id\": \"1\", \"title\":\"DIA definition\",\"course\":\"1\",\"lecture\":\"1\", \"question\":\"What does D I A stands for in DIA Cycle?\", \"answer\":\"Design,Implementation,Analysis\"}"
    ",{\"id\": \"2\", \"title\":\"gulfs\",\"course\":\"1\",\"lecture\":\"4\", \"question\":\"What are gulfs?\", \"answer\":\"problems that arise in the interaction between user and machines\"}"
    ",{\"id\": \"3\", \"title\":\title\",\"course\":\"1\",\"lecture\":\"2\", \"question\":\"What are the 10 Golden Rules?\", \"answer\":\"1. \r...\r 9.Target bla bla bla \r 10. Hire a graphic designer\"}"
    ",{\"id\": \"4\", \"title\":\"title\",\"course\":\"1\",\"lecture\":\"2\", \"question\":\"Why do we study DIS\", \"answer\":\"Because we need the credits!\"}"
    ",{\"id\": \"5\", \"title\":\"title\",\"course\":\"1\",\"lecture\":\"1\", \"question\":\"Why do we study DIS 2\", \"answer\":\"Because we didn't learn the lesson from DIS I\"}"
    ",{\"id\": \"6\", \"title\":\"cute card\",\"course\":\"2\",\"lecture\":\"3\", \"question\":\"What are the carachteristics of a mobile device?\", \"answer\":\"small screen, one app at a time, one screen at a time, low memory...\"}"
    ",{\"id\": \"7\", \"title\":\"nice card\",\"course\":\"2\",\"lecture\":\"2\", \"question\":\"what can we use to play sound in iOS?\", \"answer\":\"AVFoundation, Open Audio, simple playback\"}"
    ",{\"id\": \"8\", \"title\":\"sweet card\",\"course\":\"2\",\"lecture\":\"2\", \"question\":\"what is a NSManagedObject\", \"answer\":\"it represent an object in the db managed by core data\"}"
    ",{\"id\": \"9\", \"title\":\"dis card\",\"course\":\"2\",\"lecture\":\"4\", \"question\":\"what is ARC\", \"answer\":\"Automatic Reference Counter\"}"
    ",{\"id\": \"10\", \"title\":\"dis 2 card\",\"course\":\"2\",\"lecture\":\"4\", \"question\":\"can we call releas inside ARC\", \"answer\":\"No, because ARC automatically manage the memory\"}"
    ",{\"id\": \"11\", \"title\":\"another card\",\"course\":\"2\",\"lecture\":\"3\", \"question\":\"Should we switch to Swift?\", \"answer\":\"I guess so, yhea. But we have time\"}"
    
    "]";
    
    // parse it and load it in an array
    NSError *error;
    _storeCards = [NSJSONSerialization JSONObjectWithData:[storeCardsString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    if (error)
        NSLog(@"JSONObjectWithData error: %@", error);
    
    // data ready to use from here on
    
    
    
    
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_storeCards count];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
