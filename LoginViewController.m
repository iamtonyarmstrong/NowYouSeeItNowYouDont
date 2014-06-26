//
//  LoginViewController.m
//  NowYouSeeNowYouDont
//
//  Created by Anthony Armstrong on 6/22/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
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

#pragma mark - Capture Touch Events/IBActions
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}


- (IBAction)loginButtonPressed:(id)sender
{
    NSString * username = [self.usernameField.text
                           stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString * password = [self.passwordField.text
                           stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if ((username.length == 0) || (password.length == 0)) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Mistake!"
                                                            message:@"Please enter a user name, and password"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    } else {
        [PFUser logInWithUsernameInBackground:username
                                     password:password
                                        block:^(PFUser *user, NSError *error) {
                                            if (error) {
                                                // The login failed. Check error to see why.
                                                NSLog(@"There was a problem");
                                                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Sorry!"
                                                                                                message:[error.userInfo objectForKey:@"error"]
                                                                                               delegate:self
                                                                                      cancelButtonTitle:@"OK"
                                                                                      otherButtonTitles:nil];
                                                [alert show];

                                                NSString *errorString = [error userInfo][@"error"];
                                                NSLog(@"%@", errorString);
                                            } else {
                                                // Do stuff after successful login.
                                                [self.navigationController popToRootViewControllerAnimated:YES];
                                                NSLog(@"Hooray!! Login in success");

                                            }
                                        }];
    }
}
@end
