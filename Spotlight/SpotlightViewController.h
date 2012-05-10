//
//  SpotlightViewController.h
//  Spotlight
//
//  Created by Ryan on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpotlightViewController;
@protocol SpotlightViewControllerDelegate<NSObject>
@optional
- (void)viewController:(SpotlightViewController *)viewController didPressButton:(UIButton *)button;
@end

@interface SpotlightViewController : UIViewController
@property (nonatomic, assign) id<SpotlightViewControllerDelegate> delegate;

- (void)animateSpotlight:(CGRect)buttonFrame withButtonText:(NSString *)buttonText withSpotlightCenter:(CGPoint)spotCenter withSpotlightRadius:(NSInteger)spotRadius;
- (void)setButtonGradient:(UIColor *)inHighColor andLowColor:(UIColor *)inLowColor;
@end
