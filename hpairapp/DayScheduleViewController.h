//
//  DayScheduleViewController.h
//  hpairapp
//
//  Created by Erik Godard on 6/24/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Schedule;

@interface DayScheduleViewController : UITableViewController

@property (nonatomic, strong) Schedule* currentSchedule;

@end
