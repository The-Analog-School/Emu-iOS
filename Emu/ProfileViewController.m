//
//  ProfileViewController.m
//  Emu
//
//  Created by Christopher Constable on 10/1/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "ProfileViewController.h"
#import "EmuUtilities.h"

#import <CoreLocation/CoreLocation.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (IBAction)settingsWasPressed:(id)sender {
    [[self emuTabBarController] showSettings];
}

@end
