//
//  EmuViewController.m
//  Emu
//
//  Created by Christopher Constable on 10/1/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "EmuViewController.h"

@interface EmuViewController ()

@end

@implementation EmuViewController

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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor snowColor];
}

- (void)enableBackgroundTapToDismissKeyboard
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(backgroundWasTapped:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)backgroundWasTapped:(UITapGestureRecognizer *)tapGesture
{
    [self.view endEditing:YES];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      
                                                      id keyboardData = [[note userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey];
                                                      CGSize keyboardSize = [keyboardData CGRectValue].size;
                                                      
                                                      [UIView animateWithDuration:0.5
                                                                            delay:0.0
                                                                          options:UIViewAnimationOptionCurveEaseInOut
                                                                       animations:^{
                                                                           CGRect newFrame = self.view.frame;
                                                                           newFrame.origin.y -= keyboardSize.height;
                                                                           self.view.frame = newFrame;
                                                                       } completion:nil];
                                                  }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      
                                                      id keyboardData = [[note userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey];
                                                      CGSize keyboardSize = [keyboardData CGRectValue].size;
                                                      
                                                      [UIView animateWithDuration:0.1
                                                                            delay:0.0
                                                                          options:UIViewAnimationOptionCurveEaseInOut
                                                                       animations:^{
                                                                           CGRect newFrame = self.view.frame;
                                                                           newFrame.origin.y += keyboardSize.height;
                                                                           self.view.frame = newFrame;
                                                                       } completion:nil];
                                                  }];
}

@end
