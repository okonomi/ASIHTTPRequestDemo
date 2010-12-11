//
//  BasicRequestViewController.h
//  ASIHTTPRequestDemo
//
//  Created by okonomi on 10/12/04.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"


@interface BasicRequestDemoViewController : UIViewController {
    UIProgressView *_progressView;
}

@property (nonatomic,retain) UIProgressView *progressView;

@end
