//
//  EditEventViewController.h
//  Emu
//
//  Created by Christopher Constable on 10/3/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "EmuViewController.h"

@interface EditEventViewController : EmuViewController

@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionTextView;

- (IBAction)submitButtonPressed:(id)sender;

@end
