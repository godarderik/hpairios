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

@property (strong, nonatomic) UIImageView *mapImageView;
@property (strong, nonatomic) UIScrollView *scrollView;

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
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    
    NSString *photoString = self.mapMapping[self.mapID];
    
    self.mapImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:photoString]];
    //self.mapImageView.frame = self.scrollView.frame;
    self.mapImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    self.scrollView.contentSize = self.mapImageView.image.size;
    self.scrollView.contentMode = UIViewContentModeScaleAspectFit;
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 6.0f;
    self.scrollView.minimumZoomScale = 0.1f;
    self.scrollView.zoomScale = 0.42f;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    [self.scrollView addSubview:self.mapImageView];
    [self.view addSubview:self.scrollView];
    // Do any additional setup after loading the view.
}

- (void)setMapID:(NSString *)mapID {
    _mapID = mapID;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.mapImageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
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
