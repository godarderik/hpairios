//
//  NotificationsTableViewController.h
//  hpairapp
//
//  Created by Erik Godard on 6/22/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataLoader.h"

@class NotificationItem;

@interface NotificationsTableViewController : UITableViewController <DataLoaderReceiver>

@property (nonatomic, copy) NSArray<NotificationItem *> *notifications;

@end
