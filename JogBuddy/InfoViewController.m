//
//  InfoViewController.m
//  JogBuddy
//
//  Created by Mohammad Azam on 7/23/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import "InfoViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation InfoViewController

@synthesize jogInfo,distanceLabel,stopButton; 

-(id) initWithJogInfo:(JogInfo *)ji
{
    self = [super init]; 
    self.jogInfo = ji; 
    return self; 
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.distanceLabel sizeToFit]; 
    [self.distanceLabel setText:[NSString stringWithFormat:@"%.02f miles",self.jogInfo.distance]];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"sky.jpg"];

    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"sky.jpg"]];
    
    // Create the path (with only the top-left corner rounded)
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.stopButton.bounds 
                                                   byRoundingCorners:UIRectCornerAllCorners  
                                                         cornerRadii:CGSizeMake(12.0, 12.0)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.stopButton.bounds;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the image view's layer
    self.stopButton.layer.mask = maskLayer;
    
//    [[self.stopButton layer] setCornerRadius:8.0f];
//    [[self.stopButton layer] setMasksToBounds:YES];
//    [[self.stopButton layer] setBorderWidth:1.0f];
//    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
