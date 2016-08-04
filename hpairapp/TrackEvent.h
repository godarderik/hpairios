//
//  TrackEvent.h
//  hpairapp
//
//  Created by Erik Godard on 7/20/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackEvent : NSObject

@property (strong, nonatomic) NSNumber *trackEventID;
@property (copy, nonatomic) NSString *trackEventName;
@property (copy, nonatomic) NSString *trackEventDescription;
@property (copy, nonatomic) NSString *trackEventStartTime;
@property (copy, nonatomic) NSString *trackEventEndTime;
@property (copy, nonatomic) NSString *trackEventDate;

@end
