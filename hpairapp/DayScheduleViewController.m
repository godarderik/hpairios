//
//  DayScheduleViewController.m
//  hpairapp
//
//  Created by Erik Godard on 6/24/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import "DayScheduleViewController.h"
#import "Schedule.h"
#import "ScheduleEventTableViewCell.h"

static NSString *mapTableViewCellLabel = @"SingleTrackTableViewCellLabel";

@interface DayScheduleViewController ()

@end
@implementation DayScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.currentSchedule.scheduleDate;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140;
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
    return self.currentSchedule.scheduleEvents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    ScheduleEventTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:mapTableViewCellLabel];
    
    if (cell == nil) {
        [self.tableView registerNib:[UINib nibWithNibName:@"ScheduleEventTableViewCell" bundle:nil] forCellReuseIdentifier:mapTableViewCellLabel];
        cell = [tableView dequeueReusableCellWithIdentifier:mapTableViewCellLabel];
    }
    
    ScheduleEvent* event = [self.currentSchedule.scheduleEvents objectAtIndex:indexPath.row];
    cell.eventName.text = event.scheduleEventName;
    cell.eventDescription.text = event.scheduleEventDescription;
    cell.eventTime.text = [NSString stringWithFormat:@"%@ - %@", event.scheduleEventStartTime, event.scheduleEventEndTime];
    cell.eventLocation.text = event.location;
        
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
