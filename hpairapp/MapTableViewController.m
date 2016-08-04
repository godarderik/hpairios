//
//  MapTableViewController.m
//  hpairapp
//
//  Created by Erik Godard on 6/12/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import "MapTableViewController.h"
#import "SingleMapViewController.h"

@interface MapTableViewController ()

@property (nonatomic, copy) NSArray* maps;

@end

@implementation MapTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.maps = @[@"Subway", @"CUHK Campus"];

    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.maps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *mapTableViewCellLabel = @"MapTableViewCellLabel";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mapTableViewCellLabel];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mapTableViewCellLabel];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [self.maps objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.toShowMapID = [self.maps objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showMap" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"showMap"])
    {
        SingleMapViewController* mapVC = (SingleMapViewController*)[segue destinationViewController];
        mapVC.mapID = self.toShowMapID;
    }
}


@end
