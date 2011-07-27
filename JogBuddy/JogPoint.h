

#import <MapKit/MapKit.h>


@interface JogPoint : NSObject <MKOverlay>
{
    MKMapPoint *points; 
    MKMapRect boundingMapRect;
    NSInteger pointCount; 
    NSInteger pointSpace; 
}

@property (nonatomic,readonly) MKMapPoint *points; 


-(void) addCoordinates:(CLLocationCoordinate2D) coord; 

@end
