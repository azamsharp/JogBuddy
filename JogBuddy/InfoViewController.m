//
//  InfoViewController.m
//  JogBuddy
//
//  Created by Mohammad Azam on 7/23/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import "InfoViewController.h"

@implementation InfoViewController

@synthesize jogInfo,distanceLabel,backButton; 

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

-(IBAction)backButtonClicked 
{
    
    
    NSLog(@"backbuttonclicked");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.distanceLabel sizeToFit]; 
    [self.distanceLabel setText:[NSString stringWithFormat:@"%.02f miles",self.jogInfo.distance]];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"fiberglass.jpg"];

    
   // self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"fiberglass.jpg"]];
    
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
