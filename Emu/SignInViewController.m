//
//  SignInViewController.m
//  Emu
//
//  Created by Christopher Constable on 9/29/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <Parse/Parse.h>
#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self enableBackgroundTapToDismissKeyboard];
    [self registerForKeyboardNotifications];
    
    self.emuImageView.layer.cornerRadius = self.emuImageView.frame.size.width / 2;
    self.emuImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.emuImageView.layer.borderWidth = 3.0;
    self.emuImageView.clipsToBounds = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - Actions

- (IBAction)signInPressed:(id)sender {
    [self.view endEditing:YES];
    
    [PFUser logInWithUsernameInBackground:[self.usernameField.text lowercaseString]
                                 password:self.passwordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
