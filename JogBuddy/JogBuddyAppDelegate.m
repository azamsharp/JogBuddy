//
//  MapKitDemoAppDelegate.m
//  MapKitDemo
//
//  Created by Mohammad Azam on 6/27/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import "JogBuddyAppDelegate.h"

@implementation JogBuddyAppDelegate


@synthesize window=_window,jogViewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
            
    [_window addSubview:jogViewController.view]; 
    
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
   
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
   
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
