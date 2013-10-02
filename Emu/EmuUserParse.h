//
//  EmuUserParse.h
//  Emu
//
//  Created by Christopher Constable on 10/1/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>
#import "EmuUser.h"

@interface EmuUserParse : NSObject <EmuUser>

@property (nonatomic, strong) PFUser *parseUser;

+ (instancetype)userWithPFUser:(PFUser *)user;

@end
