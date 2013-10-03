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
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
       // Lots of work...
    }];
    [queue setMaxConcurrentOperationCount:2];
    
    NSBlockOperation *blockOp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"test");
    }];
    
    dispatch_queue_t myQueue = dispatch_queue_create("com.Emu.myQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(myQueue, ^{
        // Lots of work...
    });
    
    dispatch_async(myQueue, ^{
        // Lots of work...
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Lots of work...
        });
    });
    
    dispatch_async(myQueue, ^{
        // Lots of work...
    });
    
    // Appearance
    [[UIButton appearance] setTitleColor:[UIColor fadedBlueColor]
                                forState:UIControlStateNormal];
    
    return YES;
}

@end
