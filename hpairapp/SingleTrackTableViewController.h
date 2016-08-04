//
//  SingleTrackTableViewController.h
//  hpairapp
//
//  Created by Erik Godard on 6/25/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Track.h"

@class ScheduleEvent;

@interface SingleTrackTableViewController : UITableViewController

@property (strong, nonatomic) Track* track;
@property (strong, nonatomic) NSArray<ScheduleEvent *> *events;

@end
