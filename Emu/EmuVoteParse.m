//
//  EmuVoteParse.m
//  Emu
//
//  Created by Christopher Constable on 10/2/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "EmuVoteParse.h"
#import "EmuUserParse.h"

@implementation EmuVoteParse

@synthesize user = _user;
@dynamic event;

+ (NSString *)parseClassName
{
    return @"Vote";
}

- (id<EmuUser>)user
{
    EmuUserParse *user = [[EmuUserParse alloc] init];
    user.parseUser = [self objectForKey:@"user"];
    
    return user;
}

- (void)setUser:(id<EmuUser>)user
{
    EmuUserParse *userParse = user;
    PFUser *underlyingParseUserObject = userParse.parseUser;
    [self setObject:underlyingParseUserObject forKey:@"user"];
}

@end
