//
//  EmuEventParse.m
//  Emu
//
//  Created by Christopher Constable on 10/2/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "EmuEventParse.h"

@implementation EmuEventParse

@dynamic venue;
@dynamic createdUser;
@dynamic votes;
@dynamic eventStartDate;
@dynamic eventEndDate;
@dynamic attendees;
@dynamic isScheduled;

+ (NSString *)parseClassName
{
    return @"Event";
}

@end
