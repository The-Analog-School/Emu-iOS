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

@implementation FoursquareNetworkCommunicator

- (void)requestVenuesWithOptions:(NSDictionary *)options
                      completion:(VenueJSONRequestCompletionBlock)completion
{
    
    CLLocation *location = [options objectForKey:@"ll"];
    
    NSMutableString *urlString = [BASE_API_URL mutableCopy];
    [urlString appendString:@"v2/venues/explore"];
    [urlString appendFormat:@"?ll=%0.2f,%0.2f&limit=20&venuePhotos=1", location.coordinate.latitude, location.coordinate.longitude];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"keys" ofType:@"plist"];
    NSDictionary *keys = [NSDictionary dictionaryWithContentsOfFile:path];
    [urlString appendFormat:@"&client_id=%@&client_secret=%@&v=20131002", keys[@"foursquare-client-id"], keys[@"foursquare-secret"]];
    
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
