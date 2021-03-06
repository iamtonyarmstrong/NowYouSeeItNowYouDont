//
//  InboxViewController.m
//  NowYouSeeNowYouDont
//
//  Created by Anthony Armstrong on 6/22/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import "InboxViewController.h"
#import <Parse/Parse.h>

@interface InboxViewController ()

@end

@implementation InboxViewController

#pragma mark - View lifecycle methods
- (void)viewDidLoad
{
    [super viewDidLoad];



    //Shows password flow immediately when view displays if necessary...
    PFUser * currentUser = [PFUser currentUser];

    if(currentUser){
        NSLog (@"Current user: %@", currentUser.username );
    } else {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }





    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (IBAction)logoutButtonPressed:(id)sender
{
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showLogin"]){
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
}

@end
