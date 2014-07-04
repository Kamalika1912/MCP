//
//  XYZBuyCardsViewController.m
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 22/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import "XYZBuyCardsViewController.h"
#import "XYZStoreViewController.h"
#import "XYZCardPreview.h"

@interface XYZBuyCardsViewController ()

@end

@implementation XYZBuyCardsViewController

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
    // ############## LOAD CARD DATA - Load the card that I have ALREADY BOUGHT, so to not show the buy button for them
    // load locally the whole list of cards
    NSError *error;
    NSString *path;
    // load the directory or create it
    NSString *d = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) lastObject];
    if (![[NSFileManager defaultManager] fileExistsAtPath:d isDirectory:NULL]) {
        _myCardList = [NSMutableArray array];
    } else {  // else load the previously saved one
        path = [d stringByAppendingPathComponent:@"MyCards.json"];
        _myCardList = [NSArray arrayWithContentsOfFile:path];
    }
    if (error) NSLog(@"JSONObjectWithData error loading CARDS: %@", error);
    
    [_BuyList reloadData];
    
    // ############# LOAD LOCAL SAVED DATA (previously selected course and such)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // load the money // fake it to 20 if not present
    money = ([defaults objectForKey:@"money"]) != nil ? [defaults integerForKey:@"money"] : 20;
  //   self.view.backgroundColor = [UIColor clearColor ];    //show the navigation bar as it is hidden by the parent
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.BuyList.dataSource = self;
    self.BuyList.delegate = self;
    
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self isMovingFromParentViewController]) {
        //this is done to remove the navigation bar from the parent screen as it has the drop down
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}



//#################### TABLE VIEW METHODS


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_flashCardList count];
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *tagCell = [tableView dequeueReusableCellWithIdentifier:@"StoreBuyCell" forIndexPath:indexPath];
    // check if I already OWN that card and disable buying option in that case
    XYZCardPreview *cardPreview;
    if ([_myCardList indexOfObject:_flashCardList[indexPath.row]  ] != NSNotFound ) {
        cardPreview = [[XYZCardPreview alloc] initWithFlashcard:_flashCardList[indexPath.row] andBought:YES andFrame:CGRectMake(5, 5, 300 , 320)];
    } else {
        cardPreview = [[XYZCardPreview alloc] initWithFlashcard:_flashCardList[indexPath.row] andBought:NO andFrame:CGRectMake(5, 5, 300 , 320)];
        // set the row as tag in button. to know which card we are buying
        cardPreview.buy.tag=indexPath.row;
        [cardPreview.buy addTarget:self action:@selector(buyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [tagCell.contentView addSubview:cardPreview];
    return tagCell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}






//######### BUYING METHOD - just add it to myCards and save that to disk

-(void)buyButtonPressed:(UIButton *)sender {
//    NSLog(@"%@,%ld",@"BUY ",(long)sender.tag);
    
    // add the new card
    [_myCardList addObject:_flashCardList[sender.tag]];
    
    // take away one coin from the money
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:([defaults integerForKey:@"money"]-1) forKey:@"money"];
   
    // load the directory or create it
    NSString *d = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) lastObject];
    if (![[NSFileManager defaultManager] fileExistsAtPath:d isDirectory:NULL]) {
        NSError *error = nil;
        if (![[NSFileManager defaultManager] createDirectoryAtPath:d withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            //save
            [_myCardList writeToFile:[d stringByAppendingPathComponent:@"MyCards.json"] atomically:YES];
            // reaload the data, so the button becomes inactive
            [_BuyList reloadData];
        }
        
    } else {
        //save
        [_myCardList writeToFile:[d stringByAppendingPathComponent:@"MyCards.json"] atomically:YES];
        // reaload the data, so the button becomes inactive
        [_BuyList reloadData];
    }
    
}











//###### SYSTEMS STANDARD STUFF

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    NSLog(@"%@",@"We are ready for segue!");
//    flashCardList = sender;
//    [self.BuyList reloadData];
//    
//}


@end
