//
//  WebViewController.m
//  MCP-A03
//
//  Created by Giorgio Pretto on 5/8/14.
//  Copyright (c) 2014 Giorgio Pretto - Devashish Jasani - Kamalika Dutta. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end




@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




// When loading the WebViewController
// we set the internal webView delegate to self
// that way we can manage everything internally
- (void)viewDidLoad
{
    [super viewDidLoad];
    [_webView setDelegate:self];
}



// WEBVIEW IS DONE
// When the webview is done, we check if it is the succeffull authenticated page.
// if it is, then we notify our delegate, who will dismiss us and go on requesting the AccessToken
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if ( [webView.request.URL.absoluteString rangeOfString:@"https://oauth.campus.rwth-aachen.de/manage/default.aspx?q=authorized"].location!=NSNotFound)
    {
        [self.delegate viewIsDone];
//        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}


// function used to launch the webview to the specified url
-(void)openURL:(NSURL *)url
{
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}








// standard class stuff
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
