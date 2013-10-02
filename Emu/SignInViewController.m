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
    [self registerForNotifications];
    
    self.emuImageView.layer.cornerRadius = self.emuImageView.frame.size.width / 2;
    self.emuImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.emuImageView.layer.borderWidth = 3.0;
    self.emuImageView.clipsToBounds = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(backgroundWasTapped:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)registerForNotifications
{
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      
                                                      id keyboardData = [[note userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey];
                                                      CGSize keyboardSize = [keyboardData CGRectValue].size;
                                                      
                                                      [UIView animateWithDuration:0.5
                                                                            delay:0.0
                                                                          options:UIViewAnimationOptionCurveEaseInOut
                                                                       animations:^{
                                                                           CGRect newFrame = self.view.frame;
                                                                           newFrame.origin.y -= keyboardSize.height;
                                                                           self.view.frame = newFrame;
                                                                       } completion:nil];
                                                  }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      
                                                      id keyboardData = [[note userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey];
                                                      CGSize keyboardSize = [keyboardData CGRectValue].size;
                                                      
                                                      [UIView animateWithDuration:0.1
                                                                            delay:0.0
                                                                          options:UIViewAnimationOptionCurveEaseInOut
                                                                       animations:^{
                                                                           CGRect newFrame = self.view.frame;
                                                                           newFrame.origin.y += keyboardSize.height;
                                                                           self.view.frame = newFrame;
                                                                       } completion:nil];
                                                  }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - Actions

- (void)backgroundWasTapped:(UITapGestureRecognizer *)tapGesture
{
    [self.view endEditing:YES];
}

- (IBAction)signInPressed:(id)sender {
    [self.view endEditing:YES];
    
    [PFUser logInWithUsernameInBackground:self.usernameField.text
                                 password:self.passwordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
