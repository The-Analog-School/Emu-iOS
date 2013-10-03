//
//  EditEventViewController.m
//  Emu
//
//  Created by Christopher Constable on 10/3/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "EditEventViewController.h"
#import "EmuUtilities.h"
#import "EmuEvent.h"

@interface EditEventViewController ()

@property (nonatomic ,strong) id<EmuEvent> event;
@end

@implementation EditEventViewController

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
    
    [self enableBackgroundTapToDismissKeyboard];
    [self registerForKeyboardNotifications];
    
	self.event = [[EmuUtilities sharedUtilities] eventToSubmit];
    self.eventName.text = self.event.venue.name;
}

- (IBAction)submitButtonPressed:(id)sender {
    if ([self.datePicker.date compare:[NSDate date]]) {
        self.event.eventStartDate = self.datePicker.date;
        self.event.eventDescription = self.eventDescriptionTextView.text;
        [self performSegueWithIdentifier:@"Submit" sender:self];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Date"
                                                        message:@"Please make sure the date is "
                                                       delegate:nil
                                              cancelButtonTitle:@"Shucks"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    
}

@end
