//
//  XYZStartStudyingViewController.h
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 22/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZStartStudyingViewController : UIViewController<UIScrollViewDelegate>
{

//    NSMutableArray *myCardsList;
}


@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (strong, nonatomic) IBOutlet UIButton *favouriteButton;

@property (strong, nonatomic) UIScrollView *horizontalScroll;
@property (strong, nonatomic) IBOutlet UILabel *cardNumber;


@property NSArray *myCards;


- (IBAction)favouriteButtonClicked:(id)sender;


@end
