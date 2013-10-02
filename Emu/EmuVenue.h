//
//  EmuVenue.h
//  Emu
//
//  Created by Christopher Constable on 10/1/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EmuModel.h"

@class CLLocation;

@protocol EmuVenue <EmuModel>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *foursquareId;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *email;
@property (nonatomic) CGFloat rating;
@property (nonatomic, strong) NSURL *websiteUrl;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic) NSInteger totalTimesVisited;

@end
