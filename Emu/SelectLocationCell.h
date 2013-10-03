//
//  SelectLocationCell.h
//  Emu
//
//  Created by Christopher Constable on 10/3/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectLocationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *venueNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueRatingLabel;

@property (weak, nonatomic) IBOutlet UIImageView *venueImageView;

@end
