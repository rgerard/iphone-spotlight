//
//  SpotlightViewController.m
//  Spotlight
//
//  Created by Ryan on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpotlightViewControllerDemo.h"

@interface SpotlightViewControllerDemo ()
@property(strong, nonatomic) SpotlightViewController *spotlightViewController;
@property(assign, nonatomic) NSInteger numClicks;
@end

@implementation SpotlightViewControllerDemo

@synthesize spotlightViewController;
@synthesize numClicks;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.numClicks = 0;    
    
    // Create the spotlight overview, and set this class as the delegate
    self.spotlightViewController = [[SpotlightViewController alloc] init];
    [self.spotlightViewController setDelegate:self];
    [self.view addSubview:self.spotlightViewController.view];
    
    // Animate the spotlight to its first location
    [self.spotlightViewController animateSpotlight:CGRectMake(35, 80, 250, 60) withButtonText:@"Testing!" withSpotlightCenter:CGPointMake(150, 260) withSpotlightRadius:80];
}

- (void)viewController:(SpotlightViewController *)viewController didPressButton:(UIButton *)button {
    // On the first click, animate the spotlight to another location
    // On the second click, adjust the gradient of the button, and animate the spotlight to another location
    if(self.numClicks == 0) {
        self.numClicks += 1;
        
        // Animate the spotlight to its second location
        [self.spotlightViewController animateSpotlight:CGRectMake(60, 280, 220, 60) withButtonText:@"Animating the spotlight" withSpotlightCenter:CGPointMake(270, 410) withSpotlightRadius:50];
    } else if(self.numClicks == 1) {
        self.numClicks += 1;
        
        // Changing the gradient on the button
        [self.spotlightViewController setButtonGradient:[UIColor colorWithRed:0.90 green:0.66 blue:0.86 alpha:1.000] 
                                            andLowColor:[UIColor colorWithRed:0.11 green:0.59 blue:0.67 alpha:1.000]];
        
        // Animate the spotlight to its third location
        [self.spotlightViewController animateSpotlight:CGRectMake(20, 290, 200, 60) withButtonText:@"Testing the gradient" withSpotlightCenter:CGPointMake(200, 210) withSpotlightRadius:70];
    }
}

@end
