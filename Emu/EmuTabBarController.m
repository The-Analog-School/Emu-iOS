//
//  EmuTabBarController.m
//  Emu
//
//  Created by Christopher Constable on 10/1/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <Parse/Parse.h>
#import "EmuTabBarController.h"

@interface EmuTabBarController ()

@end

@implementation EmuTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    PFUser *currentUser = [PFUser currentUser];
    
    if (!currentUser) {
        UINavigationController * signUpNav = [[UIStoryboard storyboardWithName:@"Signin"
                                                                        bundle:nil] instantiateInitialViewController];
        
        [self presentViewController:signUpNav
                           animated:YES
                         completion:nil];
    }
    else {
        PFObject *photo = [PFObject objectWithClassName:@"Photo"];
        [photo setObject:@"some name" forKey:@"photoName"];
        [photo setObject:@2 forKey:@"totalLikes"];
        [photo setObject:currentUser forKey:@"user"];
        [photo saveInBackground];
        
        [currentUser saveInBackground];
    }
    
    NSLog(@"User %@", currentUser);
}

- (SettingsViewController *)settingsViewController
{
    if (!_settingsViewController) {
        _settingsViewController = [[SettingsViewController alloc] init];
    }
    
    return _settingsViewController;
}

- (void)showSettings
{
    [self.settingsViewController presentFromViewController:self
                                                  animated:YES
                                                completion:nil];
}

- (void)hideSettings
{
    [self.settingsViewController dismissViewControllerAnimated:YES
                                                    completion:nil];
}

@end
