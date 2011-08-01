//
//  InfoViewController.h
//  JogBuddy
//
//  Created by Mohammad Azam on 7/23/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JogInfo.h" 
#import "HomeViewController.h" 

@interface InfoViewController : UIViewController<UIAlertViewDelegate>
{
    JogInfo *jogInfo; 
    IBOutlet UILabel *distanceLabel; 
    IBOutlet UILabel *eclapsedTime; 
    IBOutlet UIButton *stopButton;
}

-(id) initWithJogInfo:(JogInfo *) ji;

-(IBAction) stopJog:(id)sender; 

@property (nonatomic,retain) JogInfo *jogInfo; 
@property (nonatomic,retain) IBOutlet UILabel *distanceLabel; 
@property (nonatomic,retain) IBOutlet UIButton *stopButton; 
@property (nonatomic,retain) IBOutlet UILabel *eclapsedTime; 

@end
