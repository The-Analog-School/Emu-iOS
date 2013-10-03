//
//  SelectEventLocationViewController.m
//  Emu
//
//  Created by Christopher Constable on 10/2/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "SelectEventLocationViewController.h"
#import "EmuUtilities.h"
#import "SelectLocationCell.h"

@interface SelectEventLocationViewController ()

@property (nonatomic, strong) id<EmuVenue> selectedVenue;
@property (nonatomic, strong) NSMutableArray *mapAnnotations;
@property (nonatomic, strong) NSArray *venues;

@end

@implementation SelectEventLocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.mapAnnotations = [NSMutableArray array];
    [self.locationPicker setParallaxScrollFactor:0.2];
    [self.locationPicker setDefaultMapHeight:280.0];
    [self.locationPicker setShouldCreateHideMapButton:YES];
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
                                                      [self.locationPicker.tableView reloadData];
                                                      [self updateMapAndCenterOnAnnotations];
                                                  }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    [[EmuUtilities sharedUtilities] eventObjectWithVenue:self.selectedVenue
                                                    user:[EmuUtilities currentUser]];
}

#pragma mark - LocationPickerView

- (void)locationPicker:(LocationPickerView *)locationPicker tableViewDidLoad:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:@"SelectLocationCell" bundle:nil] forCellReuseIdentifier:@"SelectLocationCell"];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.venues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectLocationCell"];
    id<EmuVenue> venue = [self.venues objectAtIndex:indexPath.row];
    
    cell.venueNameLabel.text = venue.name;
    cell.venueRatingLabel.text = [NSString stringWithFormat:@"%0.1f", venue.rating];
    cell.venueAddressLabel.text = @"Address n/a";
    cell.venueTypeLabel.text = @"Type n/a";
    cell.venueImageView.layer.cornerRadius = 3.0;
    cell.venueImageView.clipsToBounds = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedVenue = [self.venues objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"EditEvent" sender:self];
}

#pragma mark - Map View

- (void)updateMapAndCenterOnAnnotations
{
    // Remove current annotations
    if (self.mapAnnotations) {
        [self.locationPicker.mapView removeAnnotations:self.mapAnnotations];
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
        [self.locationPicker.mapView addAnnotation:annotation];
    }
    
    [self centerMapOnAnnotationsWithAnimation:YES];
}

- (void)centerMapOnAnnotationsWithAnimation:(BOOL)animated
{
    if ([self.locationPicker.mapView.annotations count] == 0) {
        return;
    }
    
    // Set the upper and lower bounds to the first location.
    CLLocationCoordinate2D upperBounds = [(MKPointAnnotation *)[self.locationPicker.mapView.annotations objectAtIndex:0] coordinate];
    CLLocationCoordinate2D lowerBounds = [(MKPointAnnotation *)[self.locationPicker.mapView.annotations objectAtIndex:0] coordinate];
    
    // Find the "corners" of the box that contains all of our locations by finding the max and min
    // longitude and latitudes.
    for(MKPointAnnotation *curAnnotation in self.locationPicker.mapView.annotations) {
        
        // Skip the user
        if (curAnnotation == (MKPointAnnotation *)self.locationPicker.mapView.userLocation) {
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
    
    [self.locationPicker.mapView setRegion:MKCoordinateRegionMake(locationCenter, locationSpan) animated:animated];
}

- (IBAction)cancelWasPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
