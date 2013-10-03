//
//  EmuEventParse.m
//  Emu
//
//  Created by Christopher Constable on 10/2/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "EmuEventParse.h"
#import "EmuUserParse.h"

@implementation EmuEventParse

@dynamic venue;
@synthesize createdUser = _createdUser;
@dynamic votes;
@dynamic eventStartDate;
@dynamic eventEndDate;
@dynamic attendees;
@dynamic isScheduled;

+ (NSString *)parseClassName
{
    return @"Event";
}

- (id<EmuUser>)createdUser
{
    EmuUserParse *user = [[EmuUserParse alloc] init];
    user.parseUser = [self objectForKey:@"createdUser"];
    
    return user;
}

- (void)setCreatedUser:(id<EmuUser>)createdUser
{
    EmuUserParse *user = createdUser;
    [self setObject:user.parseUser forKey:@"createdUser"];
}

@end
