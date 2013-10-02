//
//  EmuEvent.h
//  Emu
//
//  Created by Christopher Constable on 10/1/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EmuModel.h"
#import "EmuUser.h"
#import "EmuVenue.h"
#import "EmuVote.h"

@protocol EmuEvent <EmuModel>

@property (nonatomic, strong) id<EmuVenue> venue;
@property (nonatomic, strong) id<EmuUser> createdUser;

@property (nonatomic, strong) NSSet *votes;
@property (nonatomic, strong) NSDate *eventStartDate;
@property (nonatomic, strong) NSDate *eventEndDate;
@property (nonatomic, strong) NSSet *attendees;

@property (nonatomic) BOOL isScheduled;

@end
