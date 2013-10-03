//
//  SubmitNewEventViewController.m
//  Emu
//
//  Created by Christopher Constable on 10/3/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "SubmitNewEventViewController.h"
#import "EmuUtilities.h"

@interface SubmitNewEventViewController ()

@end

@implementation SubmitNewEventViewController

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
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[EmuUtilities sharedUtilities] createUnscheduledEvent:[[EmuUtilities sharedUtilities] eventToSubmit]
                                               withOptions:nil
                                                completion:^(BOOL success, NSError *__autoreleasing *error) {
                                                    [self dismissViewControllerAnimated:YES
                                                                             completion:nil];
                                                }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
