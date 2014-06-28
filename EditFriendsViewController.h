//
//  EditFriendsViewController.h
//  NowYouSeeNowYouDont
//
//  Created by Anthony Armstrong on 6/25/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EditFriendsViewController : UITableViewController <UITableViewDataSource>

@property (nonatomic, strong) PFUser * currentUser;

@end
