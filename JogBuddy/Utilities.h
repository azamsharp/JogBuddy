//
//  Utilities.h
//  JogBuddy
//
//  Created by Mohammad Azam on 7/27/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject



@end

@interface UIView (Utilities)

-(void) flipFromLeftAnimationStart; 
-(void) slideDownAnimationStart:(double) time; 
-(void) slideUpAnimationStart:(double) time oldRect:(CGRect) oldRectangle; 

-(void) commitAnimations; 


@end
