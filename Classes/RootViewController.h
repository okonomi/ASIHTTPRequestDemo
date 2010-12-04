//
//  RootViewController.h
//  ASIHTTPRequestDemo
//
//  Created by okonomi on 10/12/04.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
    NSArray *_listOfContents;
}

@property (nonatomic,retain) NSArray *listOfContents;

@end
