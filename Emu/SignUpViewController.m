//
//  SignUpViewController.m
//  Emu
//
//  Created by Christopher Constable on 9/27/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <Parse/Parse.h>
#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (IBAction)signUpPressed:(id)sender {
    
    // Validation
    if (!self.firstNameField.text.length ||
        !self.lastNameField.text.length ||
        !self.usernameField.text.length ||
        !self.passwordField.text.length) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Missing Fields"
                                                            message:@"Looks like you didn't enter all the required fields."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Shucks"
                                                  otherButtonTitles: nil];
        [alertView show];
        return;
    }
    
    // TODO: Move this to a UserUtils class...
    
    PFUser *newUser = [PFUser user];
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    [newUser setObject:self.firstNameField.text forKey:@"firstName"];
    [newUser setObject:self.lastNameField.text forKey:@"lastName"];
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"New user signed up at %@", [newUser createdAt]);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
