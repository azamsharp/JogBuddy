//
//  WeatherService.m
//  JogBuddy
//
//  Created by Mohammad Azam on 7/18/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import "WeatherService.h"


@implementation WeatherService

NSString *const HOUSTON_WEATHER_FEED = @"http://www.google.com/ig/api?weather=Houston,TX"; 
NSString *const CURRENT_CONDITIONS = @"current_conditions";
NSString *const TEMP_F = @"temp_f"; 
NSString *const CONDITION = @"condition";
NSString *const ICON = @"icon";

BOOL currentConditionFound; 

@synthesize weatherInfo,url; 

-(id) initWithFeedUrl:(NSString *)feedUrl
{
    self = [super init]; 
    self.url = feedUrl; 
    return self;
}

-(WeatherInfo *) getWeatherInfo
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:[[NSURL alloc] initWithString:self.url]];
    [parser setDelegate:self];
    [parser parse];
    
    // assign images 
    [self assignImagesToWeatherConditions]; 
    
    return self.weatherInfo; 
}


-(void) assignImagesToWeatherConditions 
{
    NSLog(@"%@",self.weatherInfo.weatherCondition);
    
    if([self.weatherInfo.weatherCondition isEqualToString:@"Sunny"]) 
    {
        self.weatherInfo.weatherConditionImage = @"sunny_flower.jpg"; 
    }
    else if([self.weatherInfo.weatherCondition isEqualToString:@"Partly Cloudy"]) 
    {
        self.weatherInfo.weatherConditionImage = @"cloudy.jpg"; 
      //  self.weatherInfo.weatherConditionImage = @"partlycloudy.jpg";
    }
    else if([self.weatherInfo.weatherCondition isEqualToString:@"Showers"]) 
    {
        self.weatherInfo.weatherConditionImage = @"sunny_flower.jpg";
    }
    else 
    {
        self.weatherInfo.weatherConditionImage = @"sunny_flower.jpg"; 
    }
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:CURRENT_CONDITIONS]) {
        self.weatherInfo = [[WeatherInfo alloc] init];
        currentConditionFound = YES; 
    }
    
    if([elementName isEqualToString:CONDITION] && currentConditionFound == YES)
    {
        self.weatherInfo.weatherCondition = [attributeDict valueForKey:@"data"];
    }
    
    if([elementName isEqualToString:TEMP_F] && currentConditionFound == YES) 
    {
        self.weatherInfo.temperature = [[attributeDict valueForKey:@"data"] intValue];
        currentConditionFound = NO; 
    }
      
   }

-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to retrieve the information" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil,    nil];
    [alert show];
}


@end
