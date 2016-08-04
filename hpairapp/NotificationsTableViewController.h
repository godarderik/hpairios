//
//  NotificationsTableViewController.h
//  hpairapp
//
//  Created by Erik Godard on 6/22/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationsTableViewController : UITableViewController

@property (nonatomic, copy) NSString* toShowNotification;
@property (nonatomic, copy) NSArray* notifications;

@end
