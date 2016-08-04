//
//  SingleTrackHeaderTableViewCell.h
//  hpairapp
//
//  Created by Erik Godard on 7/22/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleTrackHeaderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *trackNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *trackDescriptionTextView;

@end
