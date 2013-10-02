//
//  EmuVote.h
//  Emu
//
//  Created by Christopher Constable on 10/1/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EmuModel.h"

@protocol EmuUser;
@protocol EmuEvent;

@protocol EmuVote <NSObject>

@property (nonatomic, strong) id<EmuUser> user;
@property (nonatomic, strong) id<EmuEvent> event;

@end
