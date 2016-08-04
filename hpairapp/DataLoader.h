//
//  DataLoader.h
//  hpairapp
//
//  Created by Erik Godard on 7/21/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataLoaderReceiver <NSObject>

@required

-(void)dataLoaded:(NSDictionary*)data;

@end

@interface DataLoader : NSObject

-(void)loadData:(NSString*)dataKey withDelegate:(id)delegate;
+(instancetype) sharedInstance;

@end
