//
//  FoursquareNetworkCommunicator.m
//  Emu
//
//  Created by Christopher Constable on 10/2/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "FoursquareNetworkCommunicator.h"
#import <AFHTTPRequestOperation.h>
#import <CoreLocation/CoreLocation.h>

NSString * const BASE_API_URL = @"https://api.foursquare.com/";
NSString * const API_KEYS = @"client_id=&client_secret=&v=20131002";

@implementation FoursquareNetworkCommunicator

- (void)requestVenuesWithOptions:(NSDictionary *)options
                      completion:(VenueJSONRequestCompletionBlock)completion
{
    
    CLLocation *location = [options objectForKey:@"ll"];
    
    NSMutableString *urlString = [BASE_API_URL mutableCopy];
    [urlString appendString:@"v2/venues/explore"];
    [urlString appendFormat:@"?ll=%0.2f,%0.2f&limit=20&venuePhotos=1", location.coordinate.latitude, location.coordinate.longitude];
    [urlString appendFormat:@"&%@", API_KEYS];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    urlRequest.HTTPMethod = @"GET";
    
    AFHTTPRequestOperation *httpRequestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    httpRequestOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [httpRequestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        if (completion) {
            completion(YES, nil, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"FS Errror: %@ %@", [error localizedDescription], [error localizedFailureReason]);
        if (completion) {
            completion(NO, nil, nil);
        }
    }];
    
    [httpRequestOperation start];
}

@end
