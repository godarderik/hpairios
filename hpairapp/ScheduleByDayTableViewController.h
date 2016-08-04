//
//  ScheduleByDayTableViewController.h
//  hpairapp
//
//  Created by Erik Godard on 6/23/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataLoader.h"

@class Schedule;

@interface ScheduleByDayTableViewController : UITableViewController <DataLoaderReceiver>

@property (nonatomic, strong) Schedule* toShowDate;

@end
