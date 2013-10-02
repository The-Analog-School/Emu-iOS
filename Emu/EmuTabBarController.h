//
//  EmuTabBarController.h
//  Emu
//
//  Created by Christopher Constable on 10/1/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"

@interface EmuTabBarController : UITabBarController

@property (nonatomic, strong) SettingsViewController *settingsViewController;

- (void)showSettings;
- (void)hideSettings;

@end
