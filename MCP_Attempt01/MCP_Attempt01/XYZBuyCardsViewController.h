//
//  XYZBuyCardsViewController.h
//  MCP_Attempt01
//
//  Created by Devashish Jasani on 22/06/14.
//  Copyright (c) 2014 Devashish Jasani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZBuyCardsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
//    NSMutableArray *flashCardList;
}


@property (weak, nonatomic) IBOutlet UITableView *BuyList;

@property NSArray *flashCardList;

@end
