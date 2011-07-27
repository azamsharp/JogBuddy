

#import "JogPoint.h"

@implementation JogPoint

@synthesize points; 

-(id) initWithCenterCoordinate:(CLLocationCoordinate2D)coord
{
    
    self = [super init]; 
    pointSpace = 1000; 
    points = malloc(sizeof(MKMapPoint) * pointSpace);
    points[0] = MKMapPointForCoordinate(coord); 
    pointCount = 1; 
    // bite off up to 1/4 of the world to draw into.
    MKMapPoint origin = points[0];
    origin.x -= MKMapSizeWorld.width / 8.0;
    origin.y -= MKMapSizeWorld.height / 8.0;
    MKMapSize size = MKMapSizeWorld;
    size.width /= 4.0;
    size.height /= 4.0;
    boundingMapRect = (MKMapRect) { origin, size };
    MKMapRect worldRect = MKMapRectMake(0, 0, MKMapSizeWorld.width, MKMapSizeWorld.height);
    boundingMapRect = MKMapRectIntersection(boundingMapRect, worldRect);

    
    return self; 
}

-(void) addCoordinates:(CLLocationCoordinate2D)coord
{
    MKMapPoint newPoint = MKMapPointForCoordinate(coord); 
    
    points[pointCount] = newPoint;
    pointCount++;
    
}

-(MKMapRect) boundingMapRect 
{
    return boundingMapRect; 
}

- (CLLocationCoordinate2D)coordinate
{
    return MKCoordinateForMapPoint(points[0]);
}

@end
