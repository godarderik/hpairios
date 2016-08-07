//
//  SingleTrackHeaderTableViewCell.m
//  hpairapp
//
//  Created by Erik Godard on 7/22/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import "SingleTrackHeaderTableViewCell.h"
#import "AppDelegate.h"

@implementation SingleTrackHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIColor *textColor = [UIColor darkGrayColor];
    
    self.trackNameLabel.textColor = delegate.darkColor;
    self.trackDescriptionTextView.textColor = textColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
