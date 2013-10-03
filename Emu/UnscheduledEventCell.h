//
//  UnscheduledEventCell.h
//  Emu
//
//  Created by Christopher Constable on 10/3/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UnscheduledEventCell;

@protocol UnscheduledEventCellDelegate <NSObject>

@optional
- (void)unscheduledEventCellVoteButtonWasPressed:(UnscheduledEventCell *)cell;

@end

@interface UnscheduledEventCell : UITableViewCell

@property (weak, nonatomic) id<UnscheduledEventCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *eventImage;
@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventCreatedUserLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *voteButton;

- (IBAction)voteButtonPressed:(id)sender;

@end
