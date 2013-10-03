//
//  EmuVenueParse.m
//  Emu
//
//  Created by Christopher Constable on 10/2/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "EmuVenueParse.h"

@implementation EmuVenueParse

@dynamic name;
@dynamic foursquareId;
@dynamic phoneNumber;
@dynamic email;
@dynamic rating;
@synthesize websiteUrl = _websiteUrl;
@synthesize photoUrl = _photoUrl;
@synthesize photo = _photo;
@synthesize location = _location;
@dynamic totalTimesVisited;

+ (NSString *)parseClassName
{
    return @"Venue";
}

+ (instancetype)objectWithJSONData:(id)jsonData
{
    EmuVenueParse *newVenue = [EmuVenueParse object];
    newVenue.foursquareId = [jsonData objectForKey:@"id"];
    newVenue.name = [jsonData objectForKey:@"name"];
    newVenue.rating = [[jsonData objectForKey:@"rating"] floatValue];
    
    // Parse out photo url
    NSArray *photoGroups = [[jsonData objectForKey:@"photos"] objectForKey:@"groups"];
    if (photoGroups.count) {
        NSDictionary *firstPhotoGroup = [photoGroups firstObject];
        if (firstPhotoGroup.count) {
            NSArray *photoItems = [firstPhotoGroup objectForKey:@"items"];
            if (photoItems.count) {
                NSDictionary *firstPhoto = [photoItems firstObject];
                NSString *photoUrlString = [NSString stringWithFormat:@"%@/100x100/%@", [firstPhoto objectForKey:@"prefix"], [firstPhoto objectForKey:@"suffix"]];
                newVenue.photoUrl = [NSURL URLWithString:photoUrlString];
            }
        }
    }
    
    NSDictionary *locationJSON = [jsonData objectForKey:@"location"];
    CGFloat latitude = [[locationJSON objectForKey:@"lat"] floatValue];
    CGFloat longitude = [[locationJSON objectForKey:@"lng"] floatValue];
    newVenue.location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    return newVenue;
}

- (CLLocation *)location
{
    PFGeoPoint *geopoint = [self objectForKey:@"location"];
    return [[CLLocation alloc] initWithLatitude:geopoint.latitude longitude:geopoint.longitude];
}

- (void)setLocation:(CLLocation *)location
{
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLocation:location];
    [self setObject:geoPoint forKey:@"location"];
}

- (NSURL *)photoUrl
{
    return [NSURL URLWithString:[self objectForKey:@"photoUrl"]];
}

- (void)setPhotoUrl:(NSURL *)photoUrl
{
    [self setObject:[photoUrl absoluteString] forKey:@"photoUrl"];
}

@end
