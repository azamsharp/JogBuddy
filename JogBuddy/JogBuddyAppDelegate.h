//
//  JogBuddyAppDelegate.h
//  JogBuddy
//
//  Created by Mohammad Azam on 7/6/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "JogViewController.h" 


@interface JogBuddyAppDelegate : NSObject <UIApplicationDelegate> {


    JogViewController *jogViewController; 
            
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic,retain) IBOutlet  JogViewController *jogViewController; 

@end
