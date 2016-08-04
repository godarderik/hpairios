//
//  SingleMapViewController.m
//  hpairapp
//
//  Created by Erik Godard on 6/21/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import "SingleMapViewController.h"

@interface SingleMapViewController ()

@property (nonatomic, copy) NSDictionary *mapMapping;

@end

@implementation SingleMapViewController

-(instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapMapping = @{
                        @"CUHK Campus": @"image02.png",
                        @"Subway": @"image00.png"
                        };
    
    NSString *photoString = self.mapMapping[self.mapID];
    self.mapImageView.image = [UIImage imageNamed:photoString];
    // Do any additional setup after loading the view.
}

- (void)setMapID:(NSString *)mapID {
    _mapID = mapID;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = self.mapID;
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
