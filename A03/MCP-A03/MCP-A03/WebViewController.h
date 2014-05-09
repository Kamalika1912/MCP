//
//  WebViewController.h
//  MCP-A03
//
//  Created by Giorgio Pretto on 5/8/14.
//  Copyright (c) 2014 Giorgio Pretto - Devashish Jasani - Kamalika Dutta. All rights reserved.
//

#import <UIKit/UIKit.h>

// define a protocol to let the caller now when we are done. That way they can dismiss us and go on
@protocol WebViewControllerDelegate <NSObject>

-(void)viewIsDone;

@end


@interface WebViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, weak) id<WebViewControllerDelegate> delegate;

-(void)openURL:(NSURL *)url;

@end
