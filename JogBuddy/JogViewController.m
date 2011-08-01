//
//  JogViewController.m
//  JogBuddy
//
//  Created by Mohammad Azam on 7/12/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import "JogViewController.h"

@implementation JogViewController

static const int OFF_SCREEN_Y_AXIS = 500; 

@synthesize mapView,locationManager,jogPoints,jogView,jogPoint,infoToolBar,speedLabel,distanceLabel,infoButton,contentView,infoView,mapSegmentedControl; 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction) segmentedControlSelectionChanged:(id) sender 
{
    UISegmentedControl *segControl = (UISegmentedControl *) sender; 
    
    int selectedIndex = [segControl selectedSegmentIndex]; 
    
    switch (selectedIndex)
    {
        case 1:  
            self.mapView.mapType = MKMapTypeSatellite;
            break; 
        case 2: 
            self.mapView.mapType = MKMapTypeHybrid; 
            break;
        default:  
            self.mapView.mapType = MKMapTypeStandard;
    }
}

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    
    [super viewDidLoad];
    
    oldSegmentControlRect = CGRectZero; 
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.contentView.bounds]; 
    
    self.jogPoints = [[NSMutableArray alloc] init]; 
    self.mapView.delegate = self; 
        
    // add the mapView to the contentView 
    [self.contentView addSubview:self.mapView]; 
    
    jogInfo = [[JogInfo alloc] init]; 
    
    self.locationManager = [[CLLocationManager alloc] init]; 
    [self.locationManager setDelegate:self];
    
    [self.locationManager startUpdatingLocation];
     
    startTime = CFAbsoluteTimeGetCurrent(); 
    
    [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
    [self.mapView setShowsUserLocation:YES];
    
}

-(IBAction) loadInfoView 
{
    
    [self.contentView flipFromLeftAnimationStart];
     
    if(CGRectIsEmpty(oldSegmentControlRect)) 
    {
        oldSegmentControlRect = self.mapSegmentedControl.frame; 
    }
    
    
    if([self.mapView superview]) 
    {        
        [self.mapSegmentedControl slideDownAnimationStart:0.75];
        
        [self.mapSegmentedControl commitAnimations]; 
        
        [self.mapView removeFromSuperview];
      
        InfoViewController *infoViewController = [[InfoViewController alloc] initWithJogInfo:jogInfo]; 
        self.infoView = infoViewController.view;
        
        [self.contentView setContentMode:UIViewContentModeScaleAspectFit]; 
        
        [UIView beginAnimations:nil context:nil]; 
        [UIView setAnimationDuration:2.0]; 

        [self.contentView addSubview:self.infoView]; 
        
        [UIView commitAnimations]; 

    }
    else 
    {    
        [self.mapSegmentedControl slideUpAnimationStart:0.75 oldRect:oldSegmentControlRect]; 
        
        [self.mapSegmentedControl commitAnimations]; 
        
        [self.view addSubview:self.mapSegmentedControl]; 

        [self.infoView removeFromSuperview];
        [self.contentView addSubview:self.mapView];
    }
        
    [self.contentView commitAnimations]; 
    
 }

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{

    if(!newLocation) return; 
 
    if ((oldLocation.coordinate.latitude != newLocation.coordinate.latitude) &&
        (oldLocation.coordinate.longitude != newLocation.coordinate.longitude))
    {
        
        NSLog(@"old location latitude %f",oldLocation.coordinate.latitude);
        NSLog(@"old location longitude %f",oldLocation.coordinate.longitude);
        
        NSLog(@"new location latitude %f",newLocation.coordinate.latitude);
        NSLog(@"new location longitude %f",newLocation.coordinate.longitude);
        
    
      jogPoint = [[JogPoint alloc] initWithCenterCoordinate:newLocation.coordinate];
      
       
       [self.jogPoints addObject:jogPoint];
  
        
        if([self.jogPoints count] >= 5) {
        
        [self.mapView addOverlay:jogPoint];  
            
        CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:oldLocation.coordinate.latitude longitude:oldLocation.coordinate.longitude];
     
        
        CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
        
        jogInfo.distance += ([loc1 distanceFromLocation:loc2]) * 0.000621371192;
        
        jogInfo.eclapsedTime = (CFAbsoluteTimeGetCurrent() - startTime) * 1000 * 60;     
            
        [self.distanceLabel setText:[NSString stringWithFormat:@"%.1lf miles",jogInfo.distance]];
        
        }
    }
    
}




- (MKOverlayView *)mapView:(MKMapView *)mv viewForOverlay:(id <MKOverlay>)overlay
{
    if(!jogView)
    {
        jogView = [[JogView alloc] initWithOverlayAndPoints:overlay pts:self.jogPoints]; 
    }
           
    return jogView; 
}

- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{    
    MKAnnotationView *annotationView = [views objectAtIndex:0];
    id<MKAnnotation> mp = [annotationView annotation];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 5000, 5000); 
    [mv setRegion:region animated:YES];
}

- (void)mapView:(MKMapView *)mv didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
   
}

- (void)dealloc
{
    [self.mapView release]; 
    self.mapView = nil; 
    
    [super dealloc];
}


@end
