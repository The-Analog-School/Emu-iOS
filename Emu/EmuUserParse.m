//
//  EmuUserParse.m
//  Emu
//
//  Created by Christopher Constable on 10/1/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "EmuUserParse.h"

@implementation EmuUserParse

@synthesize profileImage = _profileImage;

+ (instancetype)userWithPFUser:(PFUser *)user
{
    EmuUserParse *newUser = [[EmuUserParse alloc] init];
    newUser.parseUser = user;
    return newUser;
}

- (NSString *)objectId
{
    return self.parseUser.objectId;
}

- (void)setObjectId:(NSString *)objectId
{
    // intentionally empty
}

- (NSDate *)createdAt
{
    return self.parseUser.createdAt;
}

- (NSDate *)updatedAt
{
    return self.parseUser.updatedAt;
}

- (void)setUpdatedAt:(NSDate *)updatedAt
{
    // intentionally empty
}

- (NSString *)lastName
{
    return [self.parseUser objectForKey:@"lastName"];
}

- (void)setLastName:(NSString *)lastName
{
    [self.parseUser setObject:lastName forKey:@"lastName"];
}

- (NSString *)firstName
{
    return [self.parseUser objectForKey:@"firstName"];
}

- (void)setFirstName:(NSString *)firstName
{
    [self.parseUser setObject:firstName forKey:@"firstName"];
}

- (NSString *)fullName
{
    NSString *fullName = self.firstName;
    
    if (self.lastName.length) {
        fullName = [fullName stringByAppendingFormat:@" %@", self.lastName];
    }
    
    return fullName;
}

- (NSString *)username
{
    return self.parseUser.username;
}

- (void)setUsername:(NSString *)username
{
    self.parseUser.username = username;
}

- (NSString *)email
{
    return self.parseUser.email;
}

- (void)setEmail:(NSString *)email
{
    self.parseUser.email = email;
}

- (NSURL *)profileImageUrl
{
    // TODO:
    return nil;
}

- (void)setProfileImageUrl:(NSURL *)profileImageUrl
{
    // intentionally blank
}

- (void)setProfileImage:(UIImage *)profileImage
{
    // TODO:
}

@end
