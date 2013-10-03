//
//  SelectEventLocationViewController.h
//  Emu
//
//  Created by Christopher Constable on 10/2/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "EmuViewController.h"
#import "LocationPickerView.h"

@interface SelectEventLocationViewController : EmuViewController <LocationPickerViewDelegate, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet LocationPickerView *locationPicker;

- (IBAction)cancelWasPressed:(id)sender;

@end
