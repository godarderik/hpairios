//
//  ScheduleEvent.h
//  hpairapp
//
//  Created by Erik Godard on 7/20/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleEvent : NSObject

@property (strong, nonatomic) NSNumber* scheduleEventID;
@property (copy, nonatomic) NSString* scheduleEventName;
@property (copy, nonatomic) NSString* scheduleEventDescription;
@property (copy, nonatomic) NSString *scheduleEventStartTime;
@property (copy, nonatomic) NSString *scheduleEventEndTime;
@property (copy, nonatomic) NSString *scheduleEventDate;
@property (copy, nonatomic) NSString *location;

@end
