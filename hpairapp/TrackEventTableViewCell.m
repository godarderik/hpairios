//
//  TrackEventTableViewCell.m
//  hpairapp
//
//  Created by Erik Godard on 7/24/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import "TrackEventTableViewCell.h"
#import "AppDelegate.h"

@implementation TrackEventTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIColor *textColor = [UIColor darkGrayColor];

    self.eventName.textColor = delegate.darkColor;
    self.eventDate.textColor = textColor;
    self.eventTime.textColor = textColor;
    self.eventLocation.textColor = textColor;
    self.eventDescription.textColor = textColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
