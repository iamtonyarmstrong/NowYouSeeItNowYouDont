//
//  EditFriendsViewController.m
//  NowYouSeeNowYouDont
//
//  Created by Anthony Armstrong on 6/25/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import "EditFriendsViewController.h"


@interface EditFriendsViewController ()

@property (nonatomic,strong) NSArray * allUsers;

@end

@implementation EditFriendsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    PFQuery * query = [PFUser query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        } else {
            //success!!
            self.allUsers = objects;
            [self.tableView reloadData];
        }
    }];

    self.currentUser = [PFUser currentUser];

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.allUsers.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer forIndexPath:indexPath];

    PFUser * user = [self.allUsers objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;

    //test to see which users are Friends and identify them with checkmarks
    if ([self isFriend:user]) {
        //add checkmark
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        //remove checkmark
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];

    PFUser * selectedUser = [self.allUsers objectAtIndex:indexPath.row];
    PFRelation * friendsRelation = [self.currentUser relationForKey:@"friendsRelation"];

    if([self isFriend:selectedUser]){
        cell.accessoryType = UITableViewCellAccessoryNone;
        for (PFUser * friend in self.friends){
            if([friend.objectId isEqualToString:selectedUser.objectId]){
                [self.friends removeObject:friend];
                break;
            }
        }

        [friendsRelation removeObject:selectedUser];

    }else{

        [friendsRelation addObject:selectedUser];
        [self.friends addObject:selectedUser];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(error){
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Helper Methods
- (BOOL)isFriend:(PFUser *) user
{
    //look to see if users in the friends array are actually friends by comparining objectIds from Parse
    for (PFUser * friend in self.friends){
        if([friend.objectId isEqualToString:user.objectId]){
            return YES;
        }
    }
    return NO;
}

@end
