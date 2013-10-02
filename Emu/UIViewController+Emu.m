//
//  UIViewController+Emu.m
//  Emu
//
//  Created by Christopher Constable on 10/1/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "UIViewController+Emu.h"

@implementation UIViewController (Emu)

- (EmuTabBarController *)emuTabBarController
{
    id tabBarController = self.tabBarController;
    if ([tabBarController isKindOfClass:[EmuTabBarController class]] == NO) {
        tabBarController = nil;
    }
    
    return tabBarController;
}

@end
