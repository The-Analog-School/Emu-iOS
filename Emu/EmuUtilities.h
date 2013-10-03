//
//  EmuUtilities.h
//  Emu
//
//  Created by Christopher Constable on 10/1/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EmuEvent.h"

typedef void (^RequestCompletionBlock)(BOOL success, NSError **error);
typedef void (^EventRequestCompletionBlock)(BOOL success, NSError **error, NSArray *events);
typedef void (^VenueRequestCompletionBlock)(BOOL success, NSError **error, NSArray *venues);

@interface EmuUtilities : NSObject

/**
 *  Performs intialization of the app. Background services,
 *  SDK components, etc are done in here.
 */
+ (void)initializeEmuApp;
+ (id<EmuUser>)currentUser;

#pragma mark - Singleton

+ (instancetype)sharedUtilities;

#pragma mark - Emu API

/**
 *  This is the event that is currently being submitted.
 */
@property (nonatomic, strong) id<EmuEvent> eventToSubmit;

/**
 *  Creates a new event object with a user and venue. This gets
 *  set to the eventToSubmit property.
 *
 *  @param venue Event venue
 *  @param user  User that created the event
 *
 *  @return New event object.
 */
- (id<EmuEvent>)eventObjectWithVenue:(id<EmuVenue>)venue
                    user:(id<EmuUser>)user;

/**
 *  Fetches the most recent list of unscheduled events from the backend.
 *  Options can optionally be passed in to filter the results.
 *
 *  @param options         The options array can take the following values:
 *                              "beforeDate" - This pulls events starting at
 *                                             a particular date.
 *  @param completionBlock A completion block with the array of events.
 */
- (void)requestUnscheduledEventsWithOptions:(NSDictionary *)options
                                 completion:(EventRequestCompletionBlock)completionBlock;

/**
 *  Creates an "event proposal". The event should have a venue and a user set.
 *
 *  @param event           The event to create.
 *  @param options         Not currently used.
 *  @param completionBlock Returns success and error.
 */
- (void)createUnscheduledEvent:(id<EmuEvent>)event
                   withOptions:(NSDictionary *)options
                    completion:(RequestCompletionBlock)completionBlock;

/**
 *  Returns venue objects using options
 *
 *  @param options    "ll" is required.
 *  @param completion
 */
- (void)requestVenuesWithOptions:(NSDictionary *)options
                      completion:(VenueRequestCompletionBlock)completion;

/**
 *  Adds a vote to an event.
 *
 *  @param event
 *  @param completionBlock
 */
- (void)addVoteToEvent:(id<EmuEvent>)event
            completion:(RequestCompletionBlock)completionBlock;

// TODO: Add some more high-level calls here...
// Ususally we would be writing tests before we actually implement these.

@end
