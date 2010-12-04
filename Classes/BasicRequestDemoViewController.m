//
//  BasicRequestViewController.m
//  ASIHTTPRequestDemo
//
//  Created by okonomi on 10/12/04.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BasicRequestDemoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Defines.h"


enum {
    ViewTagButton = 1,
    ViewTagShow,
};


@implementation BasicRequestDemoViewController

#pragma mark -
#pragma mark BasicRequestDemoViewController

@synthesize progressView = _progressView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

#pragma mark View lifecycle

- (void)loadView {
    self.view = [[[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 460)] autorelease];
    self.view.backgroundColor = [UIColor lightGrayColor];


    NSInteger x = 10, y = 10;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(x, y, 100, 40);
    [button setTitle:NSLocalizedString(@"Download", @"Button title for download")
            forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(onConnectAction:)
     forControlEvents:UIControlEventTouchUpInside];
    button.tag = ViewTagButton;
    [self.view addSubview:button];

    y += 50;
    UIView *showView = [[[UIView alloc] initWithFrame:CGRectMake(x, y, 300, 300)] autorelease];
    showView.layer.borderWidth = 1.0f;
    showView.layer.borderColor = [UIColor grayColor].CGColor;
    showView.layer.cornerRadius = 10;
    showView.clipsToBounds = true;
    showView.tag = ViewTagShow;
    [self.view addSubview:showView];
    
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.frame = CGRectMake(0, 0, showView.frame.size.width -20, 20);
    self.progressView.center = CGPointMake(showView.frame.size.width /2, showView.frame.size.height /2);
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    LOG_CURRENT_METHOD;

    self.progressView = nil;

    [super dealloc];
}

#pragma mark Button action

- (void)onConnectAction:(id)sender {
    LOG_CURRENT_METHOD;

    UIView *showView = [self.view viewWithTag:ViewTagShow];
    for (UIView *subview in showView.subviews) {
        [subview removeFromSuperview];
    }
    self.progressView.progress = 0.0f;
    [showView addSubview:self.progressView];

    ASIHTTPRequest *httpRequest = [ASIHTTPRequest requestWithURL:
//                                   [NSURL URLWithString:@"http://www.google.co.jp/hoge"]];
                                   [NSURL URLWithString:@"http://macintoshuser.up.seesaa.net/image/steve-jobs_06.jpg"]];
    httpRequest.delegate = self;
    httpRequest.downloadProgressDelegate = self.progressView;
    [httpRequest startAsynchronous];
}

#pragma mark ASIHTTPRequest delegate

- (void)requestFinished:(ASIHTTPRequest *)request {
    LOG_CURRENT_METHOD;

    NSError *error = [request error];
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    } else {
        NSLog(@"%d:%@", [request responseStatusCode], [request responseStatusMessage]);
        if ([request responseStatusCode] / 100 == 2) {
            UIView *showView = [self.view viewWithTag:ViewTagShow];
            for (UIView *subview in showView.subviews) {
                [subview removeFromSuperview];
            }

            NSData *responseData = [request responseData];
            UIImage *image = [UIImage imageWithData:responseData];

            UIImageView *imageView = [[[UIImageView alloc]
                                       initWithFrame:CGRectMake(0, 0, showView.frame.size.width, showView.frame.size.height)]
                                      autorelease];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.image = image;

            [showView addSubview:imageView];
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    LOG_CURRENT_METHOD;
    
    NSError *error = [request error];
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

@end
