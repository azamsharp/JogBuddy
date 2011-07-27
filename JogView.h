//
//  JogView.h
//  JogBuddy
//
//  Created by Mohammad Azam on 7/12/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface JogView : MKOverlayView {
    
    NSMutableArray *pointsToPlot; 
}

-(id) initWithOverlayAndPoints:(id<MKOverlay>)overlay pts:(NSMutableArray *) points; 


@property (nonatomic,retain) NSMutableArray *pointsToPlot; 

@end
