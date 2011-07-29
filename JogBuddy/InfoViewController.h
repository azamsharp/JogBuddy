//
//  InfoViewController.h
//  JogBuddy
//
//  Created by Mohammad Azam on 7/23/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JogInfo.h" 

@interface InfoViewController : UIViewController
{
    JogInfo *jogInfo; 
    IBOutlet UILabel *distanceLabel; 
    IBOutlet UIButton *stopButton;
}

-(id) initWithJogInfo:(JogInfo *) ji;

@property (nonatomic,retain) JogInfo *jogInfo; 
@property (nonatomic,retain) IBOutlet UILabel *distanceLabel; 
@property (nonatomic,retain) IBOutlet UIButton *stopButton; 

@end
