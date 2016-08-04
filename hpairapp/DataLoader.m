//
//  DataLoader.m
//  hpairapp
//
//  Created by Erik Godard on 7/21/16.
//  Copyright © 2016 Erik Godard. All rights reserved.
//

#import "DataLoader.h"

@interface DataLoader ()

@property (copy, nonatomic) NSDictionary* urlMappings;
@property (copy, nonatomic) NSDictionary* fileMappings;
@property (copy, nonatomic) NSDictionary* versionDataKeyMappings;

@end

@implementation DataLoader

+ (instancetype)sharedInstance {
    static DataLoader *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(instancetype)init{
   //init logic here
    if (self = [super init]) {
        self.urlMappings =
            @{
            @"tracks"   : @"https://s3.amazonaws.com/hpairapi/tracks.json",
            @"schedules": @"https://s3.amazonaws.com/hpairapi/schedule.json",
            @"version"  : @"https://s3.amazonaws.com/hpairapi/version.json"
                };
        
        self.fileMappings =
            @{
              @"tracks"   : @"tracks",
              @"schedules": @"schedules",
              @"version"  : @"version"
              };
        self.versionDataKeyMappings =
            @{
              @"tracks"   : @"track-version",
              @"schedules": @"schedule-version",
              };
    }
    return self;
}

#pragma local storage

-(NSString*)filePathForFile:(NSString*)file {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:file];
}

-(NSDictionary*)parseData:(NSData *)data error:(NSError **)error {
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    return parsedObject;
}

-(NSDictionary *)retrieveStoredDataForDataKey:(NSString*)dataKey {

    NSDictionary* test = [NSDictionary dictionaryWithContentsOfFile:[self filePathForFile:self.fileMappings[dataKey]]];
    return test;
}

-(void)storeData:(NSDictionary *)data forDataKey:(NSString *)dataKey {
    
    [data writeToFile:[self filePathForFile:self.fileMappings[dataKey]] atomically:YES];
}

#pragma remote fetching

-(void)loadData:(NSString*)dataKey withDelegate:(id<DataLoaderReceiver>)delegate {
    
    [delegate dataLoaded:[self retrieveStoredDataForDataKey:dataKey]];
    [self makeVersionRequest:dataKey withDelegate:delegate];
    
}

-(void) makeVersionRequest:(NSString*)dataKey withDelegate:(id<DataLoaderReceiver>)delegate {
    
    NSLog(@"make version request");
    const NSString* versionDataKey = @"version";
    NSURL *url = [[NSURL alloc] initWithString:self.urlMappings[versionDataKey]];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (!error) {
            [self versionRequestSucceededWithData:data dataKey:dataKey delegate:delegate];
        }
    }];
    
}

-(void)versionRequestSucceededWithData:(NSData*)data dataKey:(NSString*)dataKey delegate:(id<DataLoaderReceiver>)delegate {
    
    NSError* error = nil;
    NSDictionary* versionInfo = [self parseData:data error:&error];
    
    NSDictionary *storedVersionInfo = [self retrieveStoredDataForDataKey:@"version"];
    
    for (NSString* item in self.versionDataKeyMappings.allKeys) {
        if (!storedVersionInfo || storedVersionInfo[item] < versionInfo[item]) {
            NSMutableDictionary *newDictionary = [storedVersionInfo mutableCopy];
            if (!newDictionary) {
                //on a fresh install, use the downloaded versions
                newDictionary = [versionInfo mutableCopy];
            }
            newDictionary[item] = versionInfo[item];
            
            NSLog(@"making data fetch request");
            
            [self makeNetworkRequestForDataKey:dataKey withDelegate:delegate versionInfo:newDictionary];
        }
    }
    
}

-(void) makeNetworkRequestForDataKey:(NSString*)dataKey withDelegate:(id<DataLoaderReceiver>)delegate versionInfo:(NSDictionary*)versionInfo  {
    
    NSURL *url = [[NSURL alloc] initWithString:self.urlMappings[dataKey]];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (!error) {
            NSError *error = nil;
            NSDictionary* parsedData = [self parseData:data error:&error];
            [self storeData:parsedData  forDataKey:dataKey];
            [self storeData:versionInfo forDataKey:@"version"];
            [delegate dataLoaded:parsedData];
        }
    }];
    
}



@end
