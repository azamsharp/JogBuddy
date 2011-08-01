//
//  JogView.m
//  JogBuddy
//
//  Created by Mohammad Azam on 7/12/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import "JogView.h"
#import "JogPoint.h" 


@implementation JogView

@synthesize pointsToPlot; 


-(id) initWithOverlayAndPoints:(id<MKOverlay>)overlay pts:(NSMutableArray *)points
{
    if((self = [super initWithOverlay:overlay])) 
    {
    
        self.pointsToPlot = points; 
    }
    
    return self; 
}

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context
{
    
    if(self.pointsToPlot.count < 5) return; 
    
    CGMutablePathRef path = NULL; 
    
    CGFloat lineWidth = MKRoadWidthAtZoomScale(zoomScale);
    
    path = CGPathCreateMutable(); 
    
    for(int i=0;i<([self.pointsToPlot count] -1  );i++) 
    {
      
            MKMapPoint *firstPoint = ((JogPoint *) [self.pointsToPlot objectAtIndex:i]).points; 
            MKMapPoint *secondPoint = ((JogPoint *) [self.pointsToPlot objectAtIndex:i+1]).points; 
            
            CGPoint lastCGPoint = [self pointForMapPoint:firstPoint[0]];
            CGPathMoveToPoint(path, NULL, lastCGPoint.x, lastCGPoint.y);
            
            CGPoint cgPoint = [self pointForMapPoint:secondPoint[0]];
            CGPathAddLineToPoint(path, NULL, cgPoint.x, cgPoint.y); 
        
       }
    
    CGContextAddPath(context, path);
    CGContextSetRGBStrokeColor(context, 0.0f, 0.0f, 1.0f, 0.5f);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, lineWidth);
    CGContextStrokePath(context);
    CGPathRelease(path);
    
    [self setNeedsDisplay]; 
    
  }

@end
