//
//  Utilities.m
//  JogBuddy
//
//  Created by Mohammad Azam on 7/27/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end

@implementation UIView (Utilities) 

-(void) commitAnimations 
{
    [UIView commitAnimations]; 
}

-(void) slideUpAnimationStart:(double)time oldRect:(CGRect)oldRectangle
{
    [UIView beginAnimations:nil context:nil]; 
    [UIView setAnimationDuration:time]; 
    
    self.frame = oldRectangle; 
    
}

-(void) slideDownAnimationStart:(double) time
{
    [UIView beginAnimations:nil context:nil]; 
    [UIView setAnimationDuration:time];

    self.frame = CGRectMake(self.frame.origin.x, 500, self.frame.size.width, self.frame.size.height); 
    
}

-(void) flipFromLeftAnimationStart
{
    [UIView beginAnimations:nil context:nil]; 
    [UIView setAnimationDuration:0.75]; 
    
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES]; 
        
    NSLog(@"slide Up");
}

@end
