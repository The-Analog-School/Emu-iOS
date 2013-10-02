//
//  SelectEventLocationViewController.m
//  Emu
//
//  Created by Christopher Constable on 10/2/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "SelectEventLocationViewController.h"
#import "EmuUtilities.h"

@interface SelectEventLocationViewController ()

@property (nonatomic, strong) NSMutableArray *mapAnnotations;
@property (nonatomic, strong) NSArray *venues;

@end

@implementation SelectEventLocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
	self.mapAnnotations = [NSMutableArray array];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [SVProgressHUD showWithStatus:@"Finding venues..."];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:29.654941
                                                      longitude:-82.317467];
    
    NSDictionary *options = @{@"ll": location};
    [[EmuUtilities sharedUtilities] requestVenuesWithOptions:options
                                                  completion:^(BOOL success, NSError *__autoreleasing *error, NSArray *venues) {
                                                      [SVProgressHUD dismiss];
                                                      self.venues = venues;
                                                      [self updateMapAndCenterOnAnnotations];
                                                  }];
}

- (void)updateMapAndCenterOnAnnotations
{
    // Remove current annotations
    if (self.mapAnnotations) {
        [self.mapView removeAnnotations:self.mapAnnotations];
    }
    
    // Add new annotations
    self.mapAnnotations = [NSMutableArray array];
    MKPointAnnotation *annotation;
    for (id<EmuVenue> currentVenue in self.venues) {
        annotation = [[MKPointAnnotation alloc] init];
        annotation.title = currentVenue.name;
        annotation.coordinate = currentVenue.location.coordinate;
        
        // Add MKAnnotationView to map.
        [self.mapAnnotations addObject:annotation];
        [self.mapView addAnnotation:annotation];
    }
    
    [self centerMapOnAnnotationsWithAnimation:YES];
}

- (void)centerMapOnAnnotationsWithAnimation:(BOOL)animated
{
    if ([self.mapView.annotations count] == 0) {
        return;
    }
    
    // Set the upper and lower bounds to the first location.
    CLLocationCoordinate2D upperBounds = [(MKPointAnnotation *)[self.mapView.annotations objectAtIndex:0] coordinate];
    CLLocationCoordinate2D lowerBounds = [(MKPointAnnotation *)[self.mapView.annotations objectAtIndex:0] coordinate];
    
    // Find the "corners" of the box that contains all of our locations by finding the max and min
    // longitude and latitudes.
    for(MKPointAnnotation *curAnnotation in self.mapView.annotations) {
        
        // Skip the user
        if (curAnnotation == (MKPointAnnotation *)self.mapView.userLocation) {
            continue;
        }
        
        CLLocationCoordinate2D curCoordinates = curAnnotation.coordinate;
        if(curCoordinates.latitude > upperBounds.latitude) {
            upperBounds.latitude = curCoordinates.latitude;
        }
        if(curCoordinates.latitude < lowerBounds.latitude) {
            lowerBounds.latitude = curCoordinates.latitude;
        }
        if(curCoordinates.longitude > upperBounds.longitude) {
            upperBounds.longitude = curCoordinates.longitude;
        }
        if(curCoordinates.longitude < lowerBounds.longitude) {
            lowerBounds.longitude = curCoordinates.longitude;
        }
    }
    
    // Set the region of the map view to contain all of our locations based on the calculations above.
    MKCoordinateSpan locationSpan;
    locationSpan.latitudeDelta = (upperBounds.latitude - lowerBounds.latitude) * 1.4;
    locationSpan.longitudeDelta = (upperBounds.longitude - lowerBounds.longitude) * 1.4;
    
    CLLocationCoordinate2D locationCenter;
    locationCenter.latitude = (upperBounds.latitude + lowerBounds.latitude) / 2;
    locationCenter.longitude = (upperBounds.longitude + lowerBounds.longitude) / 2;
    
    [self.mapView setRegion:MKCoordinateRegionMake(locationCenter, locationSpan) animated:animated];
}

@end
