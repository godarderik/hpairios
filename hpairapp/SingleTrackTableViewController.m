//
//  SingleTrackTableViewController.m
//  hpairapp
//
//  Created by Erik Godard on 6/25/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import "SingleTrackTableViewController.h"
#import "SingleTrackHeaderTableViewCell.h"
#import "TrackEventTableViewCell.h"
#import "ScheduleEvent.h"

static NSString *mapTableViewHeaderCellLabel = @"SingleTrackTableViewHeaderCellLabel";
static NSString *mapTableViewCellLabel = @"SingleTrackTableViewCellLabel";

@interface SingleTrackTableViewController ()

@property (copy, nonatomic) NSArray<NSString*> *headerStrings;

@end

@implementation SingleTrackTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.track.trackName;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140;
    
    self.headerStrings = @[@"Description", @"Events"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }
    return self.track.trackLocations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //Header cell
    if (indexPath.section == 0) {
        
        SingleTrackHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mapTableViewHeaderCellLabel];
        
        if (!cell) {
            [self.tableView registerNib:[UINib nibWithNibName:@"SingleTrackHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:mapTableViewHeaderCellLabel];
            cell = [tableView dequeueReusableCellWithIdentifier:mapTableViewHeaderCellLabel];
        }
    
        cell.trackNameLabel.text = self.track.trackName;
        cell.trackDescriptionTextView.text = self.track.trackDescription;
        
        [cell updateConstraintsIfNeeded];
        
        return cell;
        
        
    } else {
        
        TrackEventTableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:mapTableViewCellLabel];
        
        if (cell == nil) {
            [self.tableView registerNib:[UINib nibWithNibName:@"TrackEventTableViewCell" bundle:nil] forCellReuseIdentifier:mapTableViewCellLabel];
            cell = [tableView dequeueReusableCellWithIdentifier:mapTableViewCellLabel];
        }
        
        ScheduleEvent* event = [self.events objectAtIndex:indexPath.row];
        cell.eventName.text = event.scheduleEventName;
        cell.eventDescription.text = event.scheduleEventDescription;
        cell.eventDate.text = event.scheduleEventDate;
        cell.eventTime.text = [NSString stringWithFormat:@"%@ - %@", event.scheduleEventStartTime, event.scheduleEventEndTime];
        cell.eventLocation.text = self.track.trackLocations[[NSString stringWithFormat:@"%lu", indexPath.row + 1]];
              
        return cell;
    }
    
    return nil;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:14]];
    NSString *string = [self.headerStrings objectAtIndex:section];
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    //[view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
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
