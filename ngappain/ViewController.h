//
//  ViewController.h
//  ngappain
//
//  Created by Muhammad Taufik on 6/26/12.
//  Copyright (c) 2012 Muhammad Taufik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNoteViewController.h"
#import "CompletedViewController.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddNoteDelegate, CompletedDelegate>

@end
