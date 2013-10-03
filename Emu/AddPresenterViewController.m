//
//  AddPresenterViewController.m
//  Emu
//
//  Created by Christopher Constable on 10/3/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "AddPresenterViewController.h"

@interface AddPresenterViewController ()

@end

@implementation AddPresenterViewController

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // TODO: This method has some issues. We'll need to use notifications or
    // delegation to get better behaviour but for now this is fine.
    static BOOL recentlyPresentedAdd = NO;
    if (recentlyPresentedAdd == NO) {
        [self performSegueWithIdentifier:@"PresentAdd" sender:self];
    }
    
    recentlyPresentedAdd = !recentlyPresentedAdd;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
