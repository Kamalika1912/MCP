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
    
    //show the navigation bar as it is hidden by the parent
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


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

    //return [flashCardList count];
    return 10;
    
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSLog(@"hi");
    
    static NSString *cellIdentifierTags = @"flashCard";
    
    UITableViewCell *tagCell = [tableView dequeueReusableCellWithIdentifier:
                                cellIdentifierTags];
    if (tagCell == nil) {
        tagCell = [[UITableViewCell alloc]initWithStyle:
                   UITableViewCellStyleDefault reuseIdentifier:cellIdentifierTags];
    }
    
    XYZCardPreview *cardPreview = [[XYZCardPreview alloc] initWithFrame:CGRectMake(5, 5, 160 , 320)];
    //use initEithFlashcard:frame: later to add flashcard data to it
    
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

@end
