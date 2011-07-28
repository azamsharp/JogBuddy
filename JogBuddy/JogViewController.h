//
//  JogViewController.h
//  JogBuddy
//
//  Created by Mohammad Azam on 7/12/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "InfoViewController.h" 

#import "JogPoint.h" 
#import "JogView.h" 
#import "JogInfo.h"
#import "Utilities.h" 


@interface JogViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate> {
 
    MKMapView *mapView; 
    CLLocationManager *locationManager; 

    NSMutableArray *jogPoints; 
    JogView *jogView; 
    JogPoint *jogPoint; 
    IBOutlet UIToolbar *infoToolBar; 
    IBOutlet UILabel *distanceLabel; 
    CLLocationDistance distance; 
    IBOutlet UILabel *speedLabel; 
    IBOutlet UIButton *infoButton; 
    JogInfo *jogInfo; 
    IBOutlet UIView *contentView; 
    UIView *infoView; 
    IBOutlet UISegmentedControl *mapSegmentedControl; 
    CGRect oldSegmentControlRect; 
}

-(id) initWithCenterCoordinate:(CLLocationCoordinate2D) coord; 
-(IBAction) segmentedControlSelectionChanged:(id) sender; 
-(IBAction) loadInfoView; 

@property (nonatomic,retain) MKMapView *mapView; 
@property (nonatomic,retain) CLLocationManager *locationManager; 
@property (nonatomic,retain) NSMutableArray *jogPoints; 
@property (nonatomic,retain) JogView *jogView; 
@property (nonatomic,retain) JogPoint *jogPoint; 
@property (nonatomic,retain) IBOutlet UIToolbar *infoToolBar; 
@property (nonatomic,retain) IBOutlet UILabel *distanceLabel; 
@property (nonatomic,retain) IBOutlet UILabel *speedLabel; 
@property (nonatomic,retain) IBOutlet UIButton *infoButton; 
@property (nonatomic,retain) IBOutlet UIView *contentView; 
@property (nonatomic,retain) UIView *infoView; 
@property (nonatomic,retain) IBOutlet UISegmentedControl *mapSegmentedControl; 

@end
