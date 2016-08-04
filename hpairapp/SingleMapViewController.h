//
//  SingleMapViewController.h
//  hpairapp
//
//  Created by Erik Godard on 6/21/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleMapViewController : UIViewController

@property (nonatomic, copy) NSString*  mapID;
@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;

@end
