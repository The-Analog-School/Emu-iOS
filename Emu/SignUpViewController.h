//
//  SignUpViewController.h
//  Emu
//
//  Created by Christopher Constable on 9/27/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : EmuViewController

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

- (IBAction)signUpPressed:(id)sender;

@end
