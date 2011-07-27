//
//  WeatherService.h
//  JogBuddy
//
//  Created by Mohammad Azam on 7/18/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherInfo.h" 


@interface WeatherService : NSObject<NSXMLParserDelegate> {
    
    WeatherInfo *weatherInfo; 
    NSString *url; 
    
}

-(id) initWithFeedUrl:(NSString *) feedUrl; 


-(WeatherInfo *) getWeatherInfo; 
-(void) assignImagesToWeatherConditions; 

@property (nonatomic,retain) WeatherInfo *weatherInfo; 
@property (nonatomic,retain) NSString *url; 

@end
