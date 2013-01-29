//
//  AddNoteViewController.m
//  ngappain
//
//  Created by Muhammad Taufik on 6/26/12.
//  Copyright (c) 2012 Muhammad Taufik. All rights reserved.
//

#import "AddNoteViewController.h"

@interface AddNoteViewController ()

@property (weak, nonatomic) IBOutlet UITextField *noteField;

@end

@implementation AddNoteViewController
@synthesize noteField;
@synthesize delegate;

-(IBAction)tappedDoneButton:(id)sender {
    NSString *note = [self.noteField text];
    
    if ([self.delegate respondsToSelector:@selector(addNoteViewController:didAddNote:)] &&
        ![note isEqualToString:@""]) {
        
        [self.delegate addNoteViewController:self didAddNote:note];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"savedTask"];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender 
{
    [[NSUserDefaults standardUserDefaults] setValue:[self.noteField text] forKey:@"savedTask"];
    [[NSUserDefaults standardUserDefaults] synchronize];    
    [self dismissViewControllerAnimated:YES completion:nil];    
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.noteField setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"savedTask"]];
}

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    
    [self.noteField becomeFirstResponder];
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

- (void)viewDidUnload 
{
    [self setNoteField:nil];
    [super viewDidUnload];
}
@end
