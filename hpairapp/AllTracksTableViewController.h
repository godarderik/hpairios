//
//  AllTracksTableViewController.h
//  hpairapp
//
//  Created by Erik Godard on 6/24/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataLoader.h"

@class Track;
@class ScheduleEvent;

@interface AllTracksTableViewController : UITableViewController <DataLoaderReceiver>

@property (nonatomic, strong) NSArray<Track*> *tracks;
@property (nonatomic, strong) NSArray<ScheduleEvent*> *events;
@property (nonatomic, strong) Track* toShowTrack;

@end
