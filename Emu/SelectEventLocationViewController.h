//
//  SelectEventLocationViewController.h
//  Emu
//
//  Created by Christopher Constable on 10/2/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "EmuViewController.h"
#import <MapKit/MapKit.h>

@interface SelectEventLocationViewController : EmuViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
