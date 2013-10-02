//
//  FoursquareNetworkCommunicator.h
//  Emu
//
//  Created by Christopher Constable on 10/2/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^VenueJSONRequestCompletionBlock)(BOOL success, NSError **error, id venuesJSON);

@interface FoursquareNetworkCommunicator : NSObject

/**
 *  Return the venues around a user location.
 *
 *  @param options    Options to pass to FS. "ll" (long/lat) is
 *                    required and must be a CLLocation object.
 *  @param completion Completion
 */
- (void)requestVenuesWithOptions:(NSDictionary *)options
                      completion:(VenueJSONRequestCompletionBlock)completion;

@end
