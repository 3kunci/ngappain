//
//  CompletedViewController.m
//  ngappain
//
//  Created by Muhammad Taufik on 6/26/12.
//  Copyright (c) 2012 Muhammad Taufik. All rights reserved.
//

#import "CompletedViewController.h"

@interface CompletedViewController ()

@property (nonatomic, assign) IBOutlet UITableViewCell *completedCell;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation CompletedViewController

@synthesize completedToDos = _completedToDos;
@synthesize tableView = _tableView;
@synthesize delegate;
@synthesize completedCell = _completedCell;

- (IBAction)tappedDoneButton:(id)sender 
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(completedView:didEditedCompletedToDos:)]) {
        [self.delegate completedView:self didEditedCompletedToDos:self.completedToDos];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)purgeCompletedToDos {
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:[self.completedToDos count]];
    [self.completedToDos enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
    }];
    
    [self.completedToDos removeAllObjects];
    
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

- (IBAction)clearAll:(id)sender
{
    if ([self.completedToDos count] > 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] 
                                      initWithTitle:@"Are you sure?" 
                                      delegate:self 
                                      cancelButtonTitle:@"Nah, not really" 
                                      destructiveButtonTitle:@"Yeah, delete them!" 
                                      otherButtonTitles:nil];
        [actionSheet setBackgroundColor:[UIColor blackColor]];
        [actionSheet showFromBarButtonItem:sender animated:YES];        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)restoreTask:(id)sender {
    [(UIButton *)sender setSelected:NO];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[[sender superview] superview]];
    
    NSString *object = [self.completedToDos objectAtIndex:indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(completedView:restoreToDo:)]) {
        [self.delegate completedView:self restoreToDo:object];
    }
    
    [self.completedToDos removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.completedToDos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CompletedCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        [[NSBundle mainBundle] loadNibNamed:@"CompletedCell" owner:self options:nil];
        cell = _completedCell;
        self.completedCell = nil;
    }
    
    UILabel *completedTextLabel = (UILabel *)[cell viewWithTag:1];
    [completedTextLabel setText:[self.completedToDos objectAtIndex:indexPath.row]];
    
    UIButton *restoreButton = (UIButton *)[cell viewWithTag:2];
    [restoreButton addTarget:self action:@selector(restoreTask:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Action Sheet Delegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    if (buttonIndex != [actionSheet cancelButtonIndex]) {
        [self purgeCompletedToDos];
    }
}



@end
