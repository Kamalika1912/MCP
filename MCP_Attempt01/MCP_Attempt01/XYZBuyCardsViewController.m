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
    // STORE
    path = [[NSBundle mainBundle] pathForResource:@"MyCards" ofType:@"json"];
    _myCardList = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:&error];
    if (error) NSLog(@"JSONObjectWithData error loading CARDS: %@", error);

    
    
    
    
    
    
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
    XYZCardPreview *cardPreview = [[XYZCardPreview alloc] initWithFlashcard:_flashCardList[indexPath.row] andFrame:CGRectMake(5, 5, 160 , 320)];
    // check if I already OWN that card and disable buying option in that case
    if ([_myCardList indexOfObject:_flashCardList[indexPath.row]  ] != NSNotFound ) {
        
        //TODO UI TEAM! GO CRAZY HERE. do what you want to a card that we already own. change background, whatever. as standard i change label and disable the button but that's pretty ugly
        
        [cardPreview.buy setTitle:@"Got it" forState:UIControlStateNormal];
        cardPreview.buy.enabled = NO;
    }
        [tagCell.contentView addSubview:cardPreview];
    //tagCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return tagCell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
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
