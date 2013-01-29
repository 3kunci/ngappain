//
//  AppDelegate.m
//  ngappain
//
//  Created by Muhammad Taufik on 6/26/12.
//  Copyright (c) 2012 Muhammad Taufik. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "CompletedViewController.h"
#import "AddNoteViewController.h"

@implementation AppDelegate

@synthesize window;

- (void)customizeAppearance 
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"topbar"] forBarMetrics:UIBarMetricsDefault];

    NSDictionary *titleAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"BebasNeue" size:23.0], UITextAttributeFont, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:titleAttributes];
    [[UIBarButtonItem appearance] setBackgroundImage:[UIImage imageNamed:@"button_inactive"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:[UIImage imageNamed:@"button_active"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    [[UITableView appearance] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_tile"]]];
    [[UITableView appearanceWhenContainedIn:[AddNoteViewController class], nil] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [[UITableView appearance] setSeparatorColor:[UIColor colorWithRed:0.5 green:0.77 blue:.92 alpha:.7]];
    
    [[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:@"toolbar"] forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self customizeAppearance];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
