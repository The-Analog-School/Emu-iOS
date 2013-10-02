//
//  EmuUser.h
//  Emu
//
//  Created by Christopher Constable on 10/1/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EmuModel.h"

@protocol EmuUser <EmuModel>

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, readonly, copy) NSString *fullName;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, strong) NSURL *profileImageUrl;
@property (nonatomic, strong) UIImage *profileImage;

@end
