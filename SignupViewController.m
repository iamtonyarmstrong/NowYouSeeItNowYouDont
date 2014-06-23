//
//  SignupViewController.m
//  NowYouSeeNowYouDont
//
//  Created by Anthony Armstrong on 6/22/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import "SignupViewController.h"
#import <Parse/Parse.h>

@interface SignupViewController ()

@end

@implementation SignupViewController

#pragma mark - View lifecycle methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


#pragma mark - IBOutlet methods
- (IBAction)registerButtonWasClicked:(id)sender
{
    NSString * username = [self.usernameField.text
                                stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString * password = [self.passwordField.text
                                stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString * email = [self.emailField.text
                            stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if ((username.length == 0) || (password.length == 0) || (email.length == 0)) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Mistake!"
                                                            message:@"Please enter a user name, password and email address"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    } else {

        //Create a user using Parse.com User class
        PFUser * user = [PFUser user];
        user.username = self.usernameField.text;
        user.password = self.passwordField.text;
        user.email = self.emailField.text;

        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(!error){
                NSLog(@"Hooray!! successful");

                //This takes me back to the root - first - view in the heirarchy.
                [self.navigationController popToRootViewControllerAnimated:YES];
            } else {
                NSLog(@"There was a problem");
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Sorry!"
                                                                message:[error.userInfo objectForKey:@"error"]
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];

                NSString *errorString = [error userInfo][@"error"];
                NSLog(@"%@", errorString);
            }
        }];

    }

}


@end
