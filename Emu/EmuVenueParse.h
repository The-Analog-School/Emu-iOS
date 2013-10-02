//
//  EmuVenueParse.h
//  Emu
//
//  Created by Christopher Constable on 10/2/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>

#import "EmuVenue.h"

@interface EmuVenueParse : PFObject <PFSubclassing, EmuVenue>

+ (NSString *)parseClassName;
+ (instancetype)objectWithJSONData:(id)jsonData;

@end
