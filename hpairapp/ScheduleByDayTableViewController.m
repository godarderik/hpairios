//
//  ScheduleByDayTableViewController.m
//  hpairapp
//
//  Created by Erik Godard on 6/23/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import "ScheduleByDayTableViewController.h"
#import "DayScheduleViewController.h"
#import "Schedule.h"
#import "ScheduleEvent.h"
#import "AppDelegate.h"


@interface ScheduleByDayTableViewController ()

@property (strong, nonatomic) NSArray <Schedule*> *dates;
@property (copy, nonatomic) NSDictionary *mappings;

@end

@implementation ScheduleByDayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.mappings = @{
                          @"id":@"scheduleEventID",
                          @"name":@"scheduleEventName",
                          @"description":@"scheduleEventDescription",
                          @"startTime": @"scheduleEventStartTime",
                          @"endTime": @"scheduleEventEndTime",
                          @"date":@"scheduleEventDate",
                          @"location":@"location"
                     };
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.view.backgroundColor = delegate.darkColor;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [[DataLoader sharedInstance] loadData:@"schedules" withDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dataLoaded:(NSDictionary *)data {
    
    [self parseSchedule:data];
    
    [self reloadTableview];
}

- (void)parseSchedule:(NSDictionary *)data {
    NSMutableArray<Schedule*> *datesArray = [[NSMutableArray alloc] init];
    
    NSArray *dates = [data valueForKey:@"dates"];
    
    for (NSDictionary *datesDict in dates) {
        Schedule *schedule = [[Schedule alloc] init];
        schedule.scheduleDate = datesDict[@"date"];
        
        NSArray *scheduleEvents = [datesDict valueForKey:@"events"];
        NSMutableArray *events = [[NSMutableArray alloc] init];
        
        for (NSDictionary *scheduleDict in scheduleEvents) {
            
            ScheduleEvent *event = [[ScheduleEvent alloc] init];
            for (NSString* key in scheduleDict) {
                [event setValue:[scheduleDict valueForKey:key] forKey:self.mappings[key]];
            }
            
            [events addObject:event];
        }
        
        schedule.scheduleEvents = events;
        [datesArray addObject:schedule];
    }
    
    self.dates = datesArray;
    
    [self reloadTableview];
}

- (void) reloadTableview {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dates.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *mapTableViewCellLabel = @"ScheduleByDayTableViewCellLabel";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mapTableViewCellLabel];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mapTableViewCellLabel];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [self.dates objectAtIndex:indexPath.row].scheduleDate;
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //cell.backgroundColor = delegate.mainColor;
    cell.textLabel.textColor = delegate.darkColor;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.toShowDate = [self.dates objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showDaySchedule" sender:self];
}


#pragma mark - Navigation


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"showDaySchedule"])
    {
        DayScheduleViewController* dayVC = (DayScheduleViewController*)[segue destinationViewController];
        dayVC.currentSchedule = self.toShowDate;
    }
}


@end
