//
//  FeedViewController.h
//  Emu
//
//  Created by Christopher Constable on 10/3/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "EmuViewController.h"
#import "UnscheduledEventCell.h"

@interface FeedViewController : EmuViewController <UnscheduledEventCellDelegate, NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
