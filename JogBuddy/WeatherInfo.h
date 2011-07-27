//
//  WeatherInfo.h
//  JogBuddy
//
//  Created by Mohammad Azam on 7/18/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WeatherInfo : NSObject {
   
    NSString *weatherCondition; 
    int temperature;
    NSString *weatherConditionImage; 
    NSString *city; 
    
}

@property (nonatomic,retain) NSString *weatherCondition; 
@property (nonatomic,assign) int temperature; 
@property (nonatomic,retain) NSString *weatherConditionImage; 
@property (nonatomic,retain) NSString *city; 

@end
