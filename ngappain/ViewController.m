//
//  ViewController.m
//  ngappain
//
//  Created by Muhammad Taufik on 6/26/12.
//  Copyright (c) 2012 Muhammad Taufik. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () 

@property (nonatomic, strong) NSMutableArray *toDos;
@property (nonatomic, strong) NSMutableArray *completedToDos;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *shouldUpdateIndexPaths;
@property (nonatomic, assign) IBOutlet UITableViewCell *toDoCell;

- (void)didTheTask:(id)sender;

@end

@implementation ViewController

@synthesize toDos = _toDos;
@synthesize completedToDos = _completedToDos;
@synthesize tableView = _tableView;
@synthesize shouldUpdateIndexPaths = _shouldUpdateIndexPaths;
@synthesize toDoCell = _toDoCell;

- (NSMutableArray *)toDos 
{
    if (!_toDos) {
        
        NSArray *savedToDos = [[NSUserDefaults standardUserDefaults] objectForKey:@"toDos"];
        
        if (savedToDos && ([savedToDos count] > 0)) {
            _toDos = [savedToDos mutableCopy];
        } else {
            _toDos = [[NSMutableArray alloc] init];            
        }        
    }
    
    return _toDos;
}

- (NSMutableArray *)completedToDos 
{
    if (!_completedToDos) {
        NSArray *savedCompletedToDos = [[NSUserDefaults standardUserDefaults] objectForKey:@"completedToDos"];
        
        if (savedCompletedToDos && ([savedCompletedToDos count] > 0)) {
            _completedToDos = [savedCompletedToDos mutableCopy];
        } else {
            _completedToDos = [[NSMutableArray alloc] init];
        }
    }
    
    return _completedToDos;
}

- (NSMutableArray *)shouldUpdateIndexPaths {
    if (!_shouldUpdateIndexPaths) {
        _shouldUpdateIndexPaths = [[NSMutableArray alloc] init];
    }
    
    return _shouldUpdateIndexPaths;
}

- (void)saveToDos
{    
    [[NSUserDefaults standardUserDefaults] setValue:self.toDos forKey:@"toDos"];
    [[NSUserDefaults standardUserDefaults] setValue:self.completedToDos forKey:@"completedToDos"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ngapain_logo"]];
    [self.navigationItem setTitleView:titleView];
}

- (void)viewDidAppear:(BOOL)animated 
{
    [super viewDidAppear:animated];
    
    [self.tableView setEditing:NO];
    
    if ([self.shouldUpdateIndexPaths count] > 0) {
        [self.tableView insertRowsAtIndexPaths:self.shouldUpdateIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        
        [self.shouldUpdateIndexPaths removeAllObjects];
    }
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{
    if ([[segue identifier] isEqualToString:@"addNote"]) {
        AddNoteViewController *addNoteViewController = (AddNoteViewController *)[[segue destinationViewController] topViewController];
        addNoteViewController.delegate = self;
    } else if ([[segue identifier] isEqualToString:@"openCompleted"]) {
        CompletedViewController *completedViewController = (CompletedViewController *)[[segue destinationViewController] topViewController];
        completedViewController.delegate = self;
        completedViewController.completedToDos = self.completedToDos;
    }
}

- (IBAction)toggleEditMode:(id)sender 
{
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    
    if ([self.tableView isEditing]) {
        [button setTitle:@"Edit"];
    } else {
        [button setTitle:@"Done"];
    }
    
    [self.tableView setEditing:![self.tableView isEditing] animated:YES];
}

#pragma mark - Delegate and Datasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [self.toDos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *cellIdentifier = @"ToDoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        [[NSBundle mainBundle] loadNibNamed:@"ToDoCell" owner:self options:nil];
        cell = _toDoCell;
        self.toDoCell = nil;
    }
    
    UILabel *toDoLabel = (UILabel *)[cell viewWithTag:1];
    toDoLabel.text = [self.toDos objectAtIndex:indexPath.row];
    
    UIButton *doneButton = (UIButton *)[cell viewWithTag:2];
    [doneButton setSelected:NO];
    [doneButton addTarget:self action:@selector(didTheTask:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}
     
- (void)didTheTask:(id)sender 
{
    UIButton *theButton = (UIButton *)sender;
    
    [theButton setSelected:YES];
    
    UITableViewCell *theCell = (UITableViewCell *)[[theButton superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:theCell];

    id toDo = [self.toDos objectAtIndex:indexPath.row];
    [self.completedToDos insertObject:toDo atIndex:0];
    [self.toDos removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    [self saveToDos];    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.toDos removeObjectAtIndex:indexPath.row];
        
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        
        [self saveToDos];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSInteger sourceRow = sourceIndexPath.row;
    NSInteger destinationRow = destinationIndexPath.row;
    
    id object = [self.toDos objectAtIndex:sourceRow];
    [self.toDos removeObjectAtIndex:sourceRow];
    [self.toDos insertObject:object atIndex:destinationRow];
    [self saveToDos];
}

// these 2 delegate methods are for disabling minus button (delete sign) on tableview's edit maode

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if ([tableView isEditing]) return UITableViewCellEditingStyleNone;
    
    return UITableViewCellEditingStyleDelete;
}


#pragma mark - Add Note Delegate Method

- (void)addNoteViewController:(AddNoteViewController *)addNoteViewController didAddNote:(NSString *)note 
{
    [self.toDos insertObject:note atIndex:0];
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.shouldUpdateIndexPaths addObject:idxPath];
    
    [self saveToDos];
}

#pragma mark - Completed Delegate Method

- (void)completedView:(CompletedViewController *)completedViewController restoreToDo:(NSString *)toDo 
{
    [self.toDos addObject:toDo];
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:[self.toDos count]-1 inSection:0];
    [self.shouldUpdateIndexPaths addObject:idxPath];
    
    [self saveToDos];
}

- (void)completedView:(CompletedViewController *)completedViewController didEditedCompletedToDos:(NSMutableArray *)completedToDos 
{
    self.completedToDos = completedToDos;
    
    [self saveToDos];
}


@end
