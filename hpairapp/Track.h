//
//  Track.h
//  hpairapp
//
//  Created by Erik Godard on 7/20/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrackEvent.h"

@interface Track : NSObject

@property (strong, nonatomic) NSNumber *trackID;
@property (copy, nonatomic) NSString *trackName;
@property (copy, nonatomic) NSString *trackDescription;
@property (copy, nonatomic) NSDictionary<NSString*, NSString *> *trackLocations;

@end
