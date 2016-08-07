//
//  AllTracksTableViewController.m
//  hpairapp
//
//  Created by Erik Godard on 6/24/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import "AllTracksTableViewController.h"
#import "SingleTrackTableViewController.h"
#import "DataLoader.h"
#import "Track.h"
#import "ScheduleEvent.h"
#import "AppDelegate.h"

@interface AllTracksTableViewController ()

@property (copy, nonatomic) NSDictionary *trackResponseKeyMappings;
@property (copy, nonatomic) NSDictionary *eventResponseKeyMappings;

@end

@implementation AllTracksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Tracks";
    
    self.trackResponseKeyMappings = @{
                    @"id":@"trackID",
                    @"name":@"trackName",
                    @"description":@"trackDescription",
                    @"locations":@"trackLocations"
                    };
    
    self.eventResponseKeyMappings = @{
                      @"id":@"scheduleEventID",
                      @"name":@"scheduleEventName",
                      @"description":@"scheduleEventDescription",
                      @"startTime": @"scheduleEventStartTime",
                      @"endTime": @"scheduleEventEndTime",
                      @"date":@"scheduleEventDate"
                      };
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.view.backgroundColor = delegate.darkColor;
   
}

-(void)viewWillAppear:(BOOL)animated {
    [[DataLoader sharedInstance] loadData:@"tracks" withDelegate:self];
}

-(void)dataLoaded:(NSDictionary *)data {
    
    [self parseTracks:data];
    [self parseEvents:data];
    
    [self reloadTableview];
}

-(void)parseTracks:(NSDictionary*)data {
    //Parse tracks
    NSMutableArray<Track*> *tracksArray = [[NSMutableArray alloc] init];
    
    NSArray* tracks = [data valueForKey:@"tracks"];
    
    for (NSDictionary *parseDict in tracks) {
        
        Track *track = [[Track alloc] init];
        
        for (NSString* key in parseDict) {
            [track setValue:[parseDict valueForKey:key] forKey:self.trackResponseKeyMappings[key]];
        }
        [tracksArray addObject:track];
    }
    self.tracks = tracksArray;
}

-(void)parseEvents:(NSDictionary*)data {
    //Parse events
    NSMutableArray<ScheduleEvent*> *eventsArray = [[NSMutableArray alloc] init];
    
    NSArray* events = [data valueForKey:@"events"];
    
    for (NSDictionary *parseDict in events) {
        
        ScheduleEvent *event = [[ScheduleEvent alloc] init];
        
        for (NSString* key in parseDict) {
            [event setValue:[parseDict valueForKey:key] forKey:self.eventResponseKeyMappings[key]];
        }
        [eventsArray addObject:event];
    }
    self.events = eventsArray;
}

-(void) reloadTableview {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
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
    return self.tracks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *mapTableViewCellLabel = @"AllTracksTableViewCellLabel";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mapTableViewCellLabel];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mapTableViewCellLabel];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [self.tracks objectAtIndex:indexPath.row].trackName;
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //cell.backgroundColor = delegate.mainColor;
    cell.textLabel.textColor = delegate.darkColor;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.toShowTrack = [self.tracks objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showTrack" sender:self];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"showTrack"])
    {
        SingleTrackTableViewController* trackVC = (SingleTrackTableViewController*)[segue destinationViewController];
        trackVC.track = self.toShowTrack;
        trackVC.events = self.events;
    }
}

@end
