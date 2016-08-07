//
//  SponsorsViewController.m
//  hpairapp
//
//  Created by Erik Godard on 8/6/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import "SponsorsViewController.h"

@interface SponsorsViewController ()



@end

@implementation SponsorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Sponsors";
    
    NSArray <NSString *> *images = @[
                                   @"image0.jpg",
                                   @"image1.jpg",
                                   @"image2.jpg",
                                   @"image3.jpg",
                                   @"image4.jpg",
                                   @"image6.png",
                                   @"image7.png",
                                   @"image8.png",
                                   @"image9.jpg",
                                   @"image10.jpg",
                                   @"image11.png",
                                   @"image12.jpg",
                                   @"image13.jpg",
                                   @"image15.jpg",
                                   @"image16.jpg",
                                   @"image17.png",
                                   @"image18.png",
                                   @"image19.jpg"
                                   ];
    
    const CGFloat padding = 20.0f;
    const CGFloat sidePadding = 10.0f;
    
    CGFloat height = 3 * padding;
    
    
    
    for (int i = 0; i < images.count; ++i) {
        UIImageView *currentImage =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:images[i]]];
        currentImage.contentMode = UIViewContentModeScaleAspectFit;
        
        currentImage.frame = CGRectMake(sidePadding, height, self.view.frame.size.width - sidePadding, 200.0f);
        currentImage.center = CGPointMake(self.view.frame.size.width / 2.0f , currentImage.center.y);
        [self.contentView addSubview:currentImage];
        
        height += currentImage.frame.size.height + padding;
    }
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, height + 100.0f);
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
