//
//  Schedule.h
//  hpairapp
//
//  Created by Erik Godard on 7/20/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScheduleEvent.h"

@interface Schedule : NSObject

@property (copy, nonatomic) NSString *scheduleDate;
@property (copy, nonatomic) NSArray<ScheduleEvent *> *scheduleEvents;

@end
