//
//  HomeViewController.m
//  JogBuddy
//
//  Created by Mohammad Azam on 7/18/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import "HomeViewController.h"


@implementation HomeViewController

NSString *const GOOGLE_WEATHER_FEED = @"http://www.google.com/ig/api?weather="; 

@synthesize weatherImage,temperatureLabel,toolbar,weatherView,weatherCondition,locationManager,reverseGeoCoder,loadingLabel; 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
    
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
    [loadingLabel setHidden:YES]; 
    
    NSLog(@"postal code %@",placemark.postalCode);
    
    NSString *feedUrl = [NSString stringWithFormat:@"%@%@",GOOGLE_WEATHER_FEED,placemark.postalCode]; 
    
    WeatherService *weatherService = [[WeatherService alloc] initWithFeedUrl:feedUrl]; 
    WeatherInfo *weatherInfo = [weatherService getWeatherInfo]; 
    
    // set the city 
    weatherInfo.city = placemark.locality; 
    
    NSLog(@"City %@",weatherInfo.city);
    
    [self displayWeatherInfo:weatherInfo]; 
    [self addToolBarItemsWithWeatherInfo:weatherInfo]; 
    
}


-(void) displayWeatherInfo:(WeatherInfo *) weatherInfo 
{
    CGPoint center = weatherView.center; 
    
    [self.temperatureLabel setCenter:CGPointMake(center.x, center.y/4)]; 
   
    [self.temperatureLabel setText:[NSString stringWithFormat:@"%d F",weatherInfo.temperature]]; 
    
    [self.weatherCondition setText:weatherInfo.weatherCondition];
    [self.weatherCondition sizeToFit];    
    [self.weatherCondition setTextAlignment:UITextAlignmentCenter]; 
    
    [self.weatherCondition setCenter:CGPointMake(center.x,center.y/2)]; 
    
    self.weatherView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:weatherInfo.weatherConditionImage]];

    
    [locationManager stopUpdatingLocation]; 
}

-(IBAction) loadMap
{
    // load the Jog view 
    
    JogViewController *jogViewController = [[JogViewController alloc] init];
    self.view = jogViewController.view; 
    
}

-(void) addToolBarItemsWithWeatherInfo:(WeatherInfo *)info
{
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    
    [items removeAllObjects]; 
    
    UIBarButtonItem *startButton = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStyleBordered target:self action:@selector(loadMap)];


    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jogbuddy_logo.png"]];
    
    UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithCustomView:logoView];     
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
  [self.toolbar setItems:[NSArray arrayWithObjects:startButton, flexibleSpace,titleButton,flexibleSpace,nil] animated:YES];
    
    [startButton release]; 
    [flexibleSpace release];
    [titleButton release]; 
    [logoView release]; 
}

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation 
                                                                           *)newLocation
            fromLocation:(CLLocation *)oldLocation
{
    if(self.reverseGeoCoder == nil) {
    
    self.reverseGeoCoder = [[MKReverseGeocoder alloc] initWithCoordinate:newLocation.coordinate];
    [self.reverseGeoCoder setDelegate:self]; 
    [self.reverseGeoCoder start];
    
    }
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.locationManager = [[CLLocationManager alloc] init]; 
    [self.locationManager setDelegate:self];
    
    [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [self.locationManager startUpdatingLocation];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
