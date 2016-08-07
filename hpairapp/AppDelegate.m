//
//  AppDelegate.m
//  hpairapp
//
//  Created by Erik Godard on 6/11/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import "AppDelegate.h"
#import "DataLoader.h"
#import "NSString+MD5.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if (launchOptions) {
        NSNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        
        if (notification) {
            //receive notification here
        }
        
    }
    
    [self registerNotifications];
    
    self.mainColor = [UIColor colorWithRed:47.0/255 green:168.0/255 blue:228.0/255 alpha:1.0f];
    self.darkColor = [UIColor colorWithRed:10.0/255 green:78.0/255 blue:108.0/255 alpha:1.0f];
    self.textColor = [UIColor whiteColor];
    
    
     [[UINavigationBar appearance] setBarTintColor:self.mainColor];
    return YES;
}

- (void)registerNotifications {
    UIUserNotificationType types = (UIUserNotificationType) (UIUserNotificationTypeSound | UIUserNotificationTypeAlert);
    
    UIUserNotificationSettings *mySettings =
    [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken  {
    
    NSString* newToken = [[[NSString stringWithFormat:@"%@",deviceToken]
                           stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //send to server here
    [self sendDeviceToken:newToken];
    
}

- (void)sendDeviceToken:(NSString *)token {
    NSString *salt = @"1cfeb606c8c7f05ca9ca91d0b2618549";
    NSString *hash = [[token stringByAppendingString: salt] MD5String];
    
    NSString *post = [NSString stringWithFormat:@"device_token=%@&hash=%@", token, hash];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://guarded-reaches-59578.herokuapp.com/registerDevice"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
