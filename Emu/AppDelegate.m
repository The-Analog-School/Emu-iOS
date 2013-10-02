//
//  AppDelegate.m
//  Emu
//
//  Created by Christopher Constable on 10/1/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "AppDelegate.h"
#import "EmuUtilities.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // App Setup
    [EmuUtilities initializeEmuApp];
    
    // Appearance
    [[UIButton appearance] setTitleColor:[UIColor fadedBlueColor]
                                forState:UIControlStateNormal];
    
    return YES;
}

@end
