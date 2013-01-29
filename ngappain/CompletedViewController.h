//
//  CompletedViewController.h
//  ngappain
//
//  Created by Muhammad Taufik on 6/26/12.
//  Copyright (c) 2012 Muhammad Taufik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CompletedViewController;

@protocol CompletedDelegate <NSObject>

- (void)completedView:(CompletedViewController *)completedViewController restoreToDo:(NSString *)toDo;
- (void)completedView:(CompletedViewController *)completedViewController didEditedCompletedToDos:(NSMutableArray *)completedToDos;

@end

@interface CompletedViewController : UIViewController <UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *completedToDos;
@property (nonatomic, assign) id <CompletedDelegate> delegate;

@end
