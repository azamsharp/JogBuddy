//
//  HomeViewController.h
//  JogBuddy
//
//  Created by Mohammad Azam on 7/18/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherInfo.h" 
#import "WeatherService.h" 
#import "JogViewController.h" 


@interface HomeViewController : UIViewController<MKReverseGeocoderDelegate,CLLocationManagerDelegate> {
    
    IBOutlet UIImageView *weatherImage; 
    IBOutlet UILabel *temperatureLabel; 
    IBOutlet UIToolbar *toolbar; 
    IBOutlet UIView *weatherView; 
    IBOutlet UILabel *weatherCondition; 
    CLLocationManager *locationManager;
    MKReverseGeocoder *reverseGeoCoder;
    IBOutlet UILabel *loadingLabel; 
}

-(IBAction) loadMap; 
-(void) addToolBarItemsWithWeatherInfo:(WeatherInfo *) info; 
-(void) displayWeatherInfo:(WeatherInfo *) weatherInfo; 


@property (nonatomic,retain) IBOutlet UIImageView *weatherImage; 
@property (nonatomic,retain) IBOutlet UILabel *temperatureLabel; 
@property (nonatomic,retain) IBOutlet UIToolbar *toolbar; 
@property (nonatomic,retain) IBOutlet UIView *weatherView; 
@property (nonatomic,retain) IBOutlet UILabel *weatherCondition; 
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (nonatomic,retain) MKReverseGeocoder *reverseGeoCoder; 
@property (nonatomic,retain) IBOutlet UILabel *loadingLabel; 

@end
