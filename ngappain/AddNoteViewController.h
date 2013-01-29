//
//  AddNoteViewController.h
//  ngappain
//
//  Created by Muhammad Taufik on 6/26/12.
//  Copyright (c) 2012 Muhammad Taufik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddNoteViewController;

@protocol AddNoteDelegate <NSObject>

- (void)addNoteViewController:(AddNoteViewController *)addNoteViewController didAddNote:(NSString *)note;

@end

@interface AddNoteViewController : UITableViewController

@property (assign, nonatomic) id <AddNoteDelegate> delegate;

-(IBAction)tappedDoneButton:(id)sender;

@end
