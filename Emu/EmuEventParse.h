//
//  EmuEventParse.h
//  Emu
//
//  Created by Christopher Constable on 10/2/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>

#import "EmuEvent.h"

@interface EmuEventParse : PFObject <PFSubclassing, EmuEvent>

+ (NSString *)parseClassName;

@end
