//
//  ScheduleEventTableViewCell.m
//  hpairapp
//
//  Created by Erik Godard on 8/3/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import "ScheduleEventTableViewCell.h"
#import "AppDelegate.h"

@implementation ScheduleEventTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    

    UIColor *textColor = [UIColor darkGrayColor];
    
    self.eventName.textColor = delegate.darkColor;
    self.eventTime.textColor = textColor;
    self.eventLocation.textColor = textColor;
    self.eventDescription.textColor = textColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
