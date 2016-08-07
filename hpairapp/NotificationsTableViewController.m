//
//  NotificationsTableViewController.m
//  hpairapp
//
//  Created by Erik Godard on 6/22/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import "NotificationsTableViewController.h"
#import "AppDelegate.h"
#import "NotificationItem.h"
#import "SingleTrackHeaderTableViewCell.h"

static NSString *notificationTableViewCellLabel = @"NotificationTableViewCellLabel";

@interface NotificationsTableViewController ()

@property (strong, nonatomic) NSDictionary *eventResponseKeyMappings;

@end

@implementation NotificationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140;
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.view.backgroundColor = delegate.darkColor;
    
    self.eventResponseKeyMappings = @{
                                      @"title": @"title",
                                      @"message": @"notificationDescription"
                                      };
}


- (void)dataLoaded:(NSDictionary *)data {
    
    [self parseNotifications:data];
    [self reloadTableview];
}

- (void)parseNotifications:(NSDictionary *)data {
 
    NSArray *notifications = data[@"notifications"];
    NSMutableArray <NotificationItem *> *parsedNotifications = [NSMutableArray array];
    
    for (NSDictionary *parseDict in notifications) {
        
        NotificationItem *newItem = [[NotificationItem alloc] init];
        
        for (NSString* key in parseDict) {
            [newItem setValue:[parseDict valueForKey:key] forKey:self.eventResponseKeyMappings[key]];
        }
        
        [parsedNotifications addObject:newItem];
    }
    
    self.notifications = parsedNotifications;
 }

- (void)reloadTableview {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

-(void)viewWillAppear:(BOOL)animated {
    [[DataLoader sharedInstance] loadData:@"notifications" withDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notifications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SingleTrackHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:notificationTableViewCellLabel];
    
    if (!cell) {
        [self.tableView registerNib:[UINib nibWithNibName:@"SingleTrackHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:notificationTableViewCellLabel];
        cell = [tableView dequeueReusableCellWithIdentifier:notificationTableViewCellLabel];
    }
    
    // Configure the cell...
    
    NotificationItem *notification = [self.notifications objectAtIndex:indexPath.row];
    
    cell.trackNameLabel.text = notification.title;
    cell.trackDescriptionTextView.text = notification.notificationDescription;
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //cell.backgroundColor = delegate.mainColor;
    cell.textLabel.textColor = delegate.darkColor;
    
    return cell;
}

@end
