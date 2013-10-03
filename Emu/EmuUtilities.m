//
//  EmuUtilities.m
//  Emu
//
//  Created by Christopher Constable on 10/1/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
#import "EmuUtilities.h"
#import "FoursquareNetworkCommunicator.h"

#import "EmuUserParse.h"
#import "EmuEventParse.h"
#import "EmuVenueParse.h"
#import "EmuVoteParse.h"

@interface EmuUtilities ()
@property (nonatomic, strong) FoursquareNetworkCommunicator *foursquareNetworkCommunicator;
@end

@implementation EmuUtilities

+ (void)initializeEmuApp
{
    // Register Parse subclasses. This is so the Parse SDK knows
    // to create these objects for me when I do fetches.
    [EmuEventParse registerSubclass];
    [EmuVenueParse registerSubclass];
    [EmuVoteParse registerSubclass];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"keys" ofType:@"plist"];
    NSDictionary *keys = [NSDictionary dictionaryWithContentsOfFile:path];
    
    [Parse setApplicationId:[keys objectForKey:@"parse-app-id"]
                  clientKey:[keys objectForKey:@"parse-client-key"]];
}

+ (id<EmuUser>)currentUser
{
    PFUser *currentUser = [PFUser currentUser];
    
    EmuUserParse *user = [[EmuUserParse alloc] init];
    user.parseUser = currentUser;
    
    return user;
}

#pragma mark - Singleton

+ (instancetype)sharedUtilities
{
    static EmuUtilities *sharedUtilities;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUtilities = [[EmuUtilities alloc] init];
        sharedUtilities.foursquareNetworkCommunicator = [[FoursquareNetworkCommunicator alloc] init];
    });
    
    return sharedUtilities;
}

#pragma mark - Emu API

- (id<EmuEvent>)eventObjectWithVenue:(id<EmuVenue>)venue
                                user:(id<EmuUser>)user
{
    EmuEventParse *newEvent = [[EmuEventParse alloc] init];
    newEvent.venue = venue;
    newEvent.createdUser = user;
    
    self.eventToSubmit = newEvent;
    
    return self.eventToSubmit;
}

- (void)requestUnscheduledEventsWithOptions:(NSDictionary *)options
                                 completion:(EventRequestCompletionBlock)completionBlock
{
    PFQuery *query = [EmuEventParse query];
    [query includeKey:@"venue"];
    [query includeKey:@"createdUser"];
    [query orderByDescending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"%@", objects);
        if (completionBlock) {
            completionBlock(YES, &error, objects);
        }
    }];
}

- (void)createUnscheduledEvent:(id<EmuEvent>)event
                   withOptions:(NSDictionary *)options
                    completion:(RequestCompletionBlock)completionBlock
{
    EmuEventParse *eventParse = (EmuEventParse *)event;
    
    [eventParse saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (completionBlock) {
            completionBlock(succeeded, &error);
        }
    }];
}

- (void)requestVenuesWithOptions:(NSDictionary *)options
                      completion:(VenueRequestCompletionBlock)completion
{
    [self.foursquareNetworkCommunicator requestVenuesWithOptions:options
                                                      completion:^(BOOL success, NSError *__autoreleasing *error, id venuesJSON) {
                                                          if (success) {
                                                              NSArray *venueGroups = [[venuesJSON objectForKey:@"response"] objectForKey:@"groups"];
                                                              NSArray *venuesArrayJSON = [[venueGroups firstObject] objectForKey:@"items"];
                                                              
                                                              NSMutableArray *venueObjects = [NSMutableArray array];
                                                              [venuesArrayJSON enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                                                  NSDictionary *venueJSON = [obj objectForKey:@"venue"];
                                                                  
                                                                  EmuVenueParse *newVenue = [EmuVenueParse objectWithJSONData:venueJSON];
                                                                  [venueObjects addObject:newVenue];
                                                              }];
                                                              
                                                              if (completion) {
                                                                  completion(YES, nil, venueObjects);
                                                              }
                                                          }
                                                          else {
                                                              if (completion) {
                                                                  completion(NO, nil, nil);
                                                              }
                                                          }
                                                      }];
}

- (void)addVoteToEvent:(id<EmuEvent>)event
            completion:(RequestCompletionBlock)completionBlock
{
    EmuEventParse *eventParse = (EmuEventParse *)event;
    PFRelation *votesRelation = [eventParse relationforKey:@"votes"];
    
    PFQuery *query = [votesRelation query];
    
    EmuUserParse *user = (EmuUserParse *)[EmuUtilities currentUser];
    [query whereKey:@"user" equalTo:user.parseUser];
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (number == 0) {
            EmuVoteParse *newVote = [EmuVoteParse object];
            newVote.user = [EmuUtilities currentUser];
            newVote.event = event;
            
            [newVote saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [votesRelation addObject:newVote];
                    
                    [eventParse saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (completionBlock) {
                            completionBlock(succeeded, &error);
                        }
                    }];
                }
            }];
        }
        else {
            // A vote already exists for this user...
            if (completionBlock) {
                completionBlock(NO, &error);
            }
        }
    }];
}

@end
