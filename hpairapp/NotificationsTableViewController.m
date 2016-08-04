//
//  NotificationsTableViewController.m
//  hpairapp
//
//  Created by Erik Godard on 6/22/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import "NotificationsTableViewController.h"
#import "NotificationViewController.h"

@interface NotificationsTableViewController ()

@end

@implementation NotificationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.notifications = @[ @"Test notification 1",  @"Test notification 2",  @"Test notification 3",  @"Test notification 4",  @"Test notification 5"];
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *mapTableViewCellLabel = @"MapTableViewCellLabel";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mapTableViewCellLabel];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mapTableViewCellLabel];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [self.notifications objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.toShowNotification = [self.notifications objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showNotification" sender:self];
}


#pragma mark - Navigation



// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"showNotification"])
    {
        NotificationViewController* notificationVC = (NotificationViewController*)[segue destinationViewController];
        notificationVC.notification = self.toShowNotification;
    }
}


@end
