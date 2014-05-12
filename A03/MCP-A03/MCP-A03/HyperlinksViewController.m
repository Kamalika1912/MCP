//
//  HiperlinksViewController.m
//  MCP-A03
//
//  Created by Giorgio Pretto on 5/12/14.
//  Copyright (c) 2014 Giorgio Pretto - Devashish Jasani - Kamalika Dutta. All rights reserved.
//

#import "HyperlinksViewController.h"

@interface HyperlinksViewController ()
{
    L2PConnector *l2pConn;
    UIActivityIndicatorView *indicator;
    
}
@property NSArray *hyperlinks;

@end


@implementation HyperlinksViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
    //load an L2P connector
    l2pConn = [[L2PConnector alloc] init];
    [l2pConn setDelegate:self];
    
    // call the api
    [l2pConn getL2PHyperlinksForCourse:@"14ss-33389"];
    
    
    
    // create a loading icon while we wait for the response.
    //    stolen from http://stackoverflow.com/questions/9976278/how-to-programmatically-add-a-simple-default-loadingprogress-bar-in-iphone-app
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    
    [indicator startAnimating];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)didReceiveError:(int)statusCode
{
    // remove loading icon
    [indicator stopAnimating];
    
    // show an alert with option to retry or just accept the sad truth
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error"
                                                    message:@"We receive an error from the server"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:@"Retry", nil];
    [alert show];
    
    
}


// ALERT DISSMISSED
// when alert is dismissed, we ask for the verificationURL
- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            // do nothing if OK
            break;
        case 1: {
            // try again
            // ask for the url from the L2PConnector object and wait for the delegate method to be fired up
            [l2pConn getL2PHyperlinksForCourse:@"14ss-33389"];
            [indicator startAnimating];
        }
        default:
            break;
    }
}




// DATA RECEIVED
// load the data in our data structure and reload the tableview. Dismiss the loading animation


-(void)didReceiveData:(NSArray *)data {
    //    NSLog(@"%@%@",@"WE GOT THE DATA!",data);
    //
    _hyperlinks = data;
    //    NSLog(@"%@", data);
    //    NSLog(@"%@", _announcements);
    //    NSLog(@"%@", _announcements[0]);
    //    NSLog(@"%@", _announcements[0][@"title"]);
    [self.tableView reloadData];
    // stop animation
    [indicator stopAnimating];
    //    [indicator removeFromSuperview];
    
}













- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_hyperlinks count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HyperlinkCell" forIndexPath:indexPath];
    
    
    
    
    NSString *desc = [_hyperlinks[indexPath.row] valueForKeyPath:@"description"];
    NSString *url = [_hyperlinks[indexPath.row] valueForKeyPath:@"url"];
    NSString *notes = [_hyperlinks[indexPath.row] valueForKeyPath:@"notes"];
    
    
    // fill in the custom cell
    ((UILabel *)[cell viewWithTag:10]).text = desc;
    ((UILabel *)[cell viewWithTag:12]).text = url;
    ((UILabel *)[cell viewWithTag:11]).text = notes;
    
    return cell;
}


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
