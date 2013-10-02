//
//  SignInViewController.h
//  Emu
//
//  Created by Christopher Constable on 9/29/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : EmuViewController

@property (weak, nonatomic) IBOutlet UIImageView *emuImageView;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)signInPressed:(id)sender;

@end
