//
//  EmuModel.h
//  Emu
//
//  Created by Christopher Constable on 10/1/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EmuModel <NSObject>

@property (nonatomic, copy) NSString *objectId;
@property (nonatomic, strong, readonly) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;

@end
