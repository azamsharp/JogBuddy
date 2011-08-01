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

int const OK_BUTTON = 1; 

@synthesize jogInfo,distanceLabel,stopButton,eclapsedTime; 

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

    [self.eclapsedTime setText:[NSString stringWithFormat:@"%.02f minutes",self.jogInfo.eclapsedTime]];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"sky.JPG"];

    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:backgroundImage];
    
    self.stopButton.layer.cornerRadius = 12.0; 
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == OK_BUTTON) 
    {
       // end the jog 
        // release everything and then go to the home view 
     
        HomeViewController *homeController = [[HomeViewController alloc] init];
        self.view = homeController.view;  
        [homeController.view release]; 
    }
    
}

-(IBAction)stopJog:(id)sender
{
    // confirmation view to stop the jog or not 
    UIAlertView *confirm = [[[UIAlertView alloc] initWithTitle:@"Confirmation" message:@"Are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil] autorelease];
    [confirm show]; 
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
