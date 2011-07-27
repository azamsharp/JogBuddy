//
//  JogViewController.m
//  JogBuddy
//
//  Created by Mohammad Azam on 7/12/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import "JogViewController.h"

@implementation JogViewController

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
        
    [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
    [self.mapView setShowsUserLocation:YES];
    
}

-(IBAction) loadInfoView 
{
    [UIView beginAnimations:nil context:nil]; 
    [UIView setAnimationDuration:0.75]; 
    
    [UIView setAnimationTransition:([self.mapView superview] ?
									UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight) forView:self.contentView cache:YES]; 
    
    if(CGRectIsEmpty(oldSegmentControlRect)) 
    {
        oldSegmentControlRect = self.mapSegmentedControl.frame; 
    }
    
    
    if([self.mapView superview]) 
    {
        CGRect mapSegmentRect = self.mapSegmentedControl.bounds;  
        
        [UIView beginAnimations:nil context:nil]; 
        [UIView setAnimationDuration:0.75]; 
        [UIView setAnimationTransition:UIViewAnimationOptionTransitionNone forView:self.mapSegmentedControl cache:YES]; 
        
        self.mapSegmentedControl.frame = CGRectMake(self.mapSegmentedControl.frame.origin.x, 500, self.mapSegmentedControl.frame.size.width, self.mapSegmentedControl.frame.size.height); 
        
        [UIView commitAnimations];
        
        [self.mapView removeFromSuperview];
      
        InfoViewController *infoViewController = [[InfoViewController alloc] initWithJogInfo:jogInfo]; 
        self.infoView = infoViewController.view; 

        
        self.infoView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 
                                            self.contentView.frame.size.height + mapSegmentRect.size.height);  
        
        
        [self.contentView addSubview:self.infoView]; 
 
        
    }
    else 
    {        
        self.mapSegmentedControl.frame = oldSegmentControlRect; 
        
        [self.view addSubview:self.mapSegmentedControl]; 

        [self.infoView removeFromSuperview];
        [self.contentView addSubview:self.mapView];
    }
    
    [UIView commitAnimations]; 
    
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
  
        
        if([self.jogPoints count] >= 2) {
        
        [self.mapView addOverlay:jogPoint];  
            
        CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:oldLocation.coordinate.latitude longitude:oldLocation.coordinate.longitude];
     
        
        CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
        
        
        jogInfo.distance += ([loc1 distanceFromLocation:loc2]) * 0.000621371192;
            
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
    [super dealloc];
}


@end
