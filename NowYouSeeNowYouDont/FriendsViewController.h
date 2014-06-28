//
//  FriendsViewController.h
//  NowYouSeeNowYouDont
//
//  Created by Anthony Armstrong on 6/28/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FriendsViewController : UITableViewController

@property (nonatomic, strong) PFRelation * friendsRelation;
@property (nonatomic, strong) NSArray * friends;

@end
