//
//  CameraViewController.h
//  NowYouSeeNowYouDont
//
//  Created by Anthony Armstrong on 6/29/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface CameraViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController * imagePicker;
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, strong) PFRelation * friendsRelation;
@property (nonatomic, strong) NSArray * friends;
@property (nonatomic, strong) NSString * videoFilePath;
@property (nonatomic, strong) NSMutableArray * recipients;


- (IBAction) cancel:(id)sender;
- (IBAction) sendImage:(id)sender;
- (void) uploadMessage;

@end
