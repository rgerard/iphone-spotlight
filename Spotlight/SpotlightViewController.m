//
//  SpotlightViewController.m
//  Spotlight
//
//  Created by Ryan on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpotlightViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SpotlightViewController ()
@property (strong, nonatomic) UIButton *textBtn;
@property (assign, nonatomic) CGPoint spotPoint;
@property (assign, nonatomic) NSInteger spotRadius;
@property (strong, nonatomic) CAGradientLayer *gradientLayer;
@property (strong, nonatomic) CAShapeLayer *spotLayer;
@property (strong, nonatomic) UIColor *highColor;
@property (strong, nonatomic) UIColor *lowColor;
- (void)_buttonPress:(id)sender;
@end

@implementation SpotlightViewController

@synthesize textBtn;
@synthesize highColor;
@synthesize lowColor;
@synthesize gradientLayer;
@synthesize spotPoint;
@synthesize spotRadius;
@synthesize spotLayer;
@synthesize delegate;

- (id)init {
    self = [super init];
    if (self) {
        // Default the spot to the center of the screen
        self.spotPoint = CGPointMake(160, 240);
        self.spotRadius = 80;
        
        // Default colors for the gradient.  highColor is at the top, lowColor as at the bottom
        self.highColor = [UIColor colorWithWhite:1.000 alpha:1.000];
        self.lowColor = [UIColor colorWithRed:0.851 green:0.859 blue:0.867 alpha:1.000];
    }
    return self;
}

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [view setBackgroundColor:[UIColor clearColor]];
    
    CAShapeLayer *spotlightLayer = [CALayer layer];
    spotlightLayer.delegate = self;
    spotlightLayer.backgroundColor = [UIColor clearColor].CGColor;
    spotlightLayer.frame = CGRectMake(0, 0, 320, 480);
    [view.layer addSublayer:spotlightLayer];
    [spotlightLayer setNeedsDisplay];
    self.spotLayer = spotlightLayer;
    
    self.textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.textBtn setFrame:CGRectMake(35, 80, 250, 60)];
    [self.textBtn setBackgroundColor:[UIColor whiteColor]];
    [self.textBtn setTitle:@"Click this box to move" forState:UIControlStateNormal];
    [self.textBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[self.textBtn titleLabel] setFont:[UIFont boldSystemFontOfSize:20.0]];
    [[self.textBtn titleLabel] setLineBreakMode:UILineBreakModeWordWrap];
    [[self.textBtn titleLabel] setTextAlignment:UITextAlignmentCenter];
    [self.textBtn.layer setCornerRadius:5.0];
    [self.textBtn addTarget:self action:@selector(_buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.textBtn];
    
    // Add a gradient layer to the background of the button
    CAGradientLayer * gradient = [CAGradientLayer layer];
    [gradient setFrame:[self.textBtn bounds]];
    [gradient setCornerRadius:5.0];
    [gradient setColors:[NSArray arrayWithObjects:(id)[self.highColor CGColor], (id)[self.lowColor CGColor], nil]];
    [self.textBtn.layer insertSublayer:gradient atIndex:0];
    self.gradientLayer = gradient;
    
    self.view = view;
}

- (void)setButtonGradient:(UIColor *)inHighColor andLowColor:(UIColor *)inLowColor {
    self.highColor = inHighColor;
    self.lowColor = inLowColor;
    
    [self.gradientLayer setColors:[NSArray arrayWithObjects:(id)[self.highColor CGColor], (id)[self.lowColor CGColor], nil]];
}

- (void)_buttonPress:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(viewController:didPressButton:)]) {
        [self.delegate viewController:self didPressButton:sender];
    }
}

- (void)animateSpotlight:(CGRect)buttonFrame 
          withButtonText:(NSString *)buttonText 
     withSpotlightCenter:(CGPoint)spotlightCenter 
     withSpotlightRadius:(NSInteger)spotlightRadius {
    
    [UIView animateWithDuration:0.2 animations:^ {
        [self.textBtn setFrame:buttonFrame];
        [self.textBtn setTitle:buttonText forState:UIControlStateNormal];
        [self.gradientLayer setFrame:[self.textBtn bounds]];
        
        self.spotPoint = spotlightCenter;
        self.spotRadius = spotlightRadius;
        [self.spotLayer setNeedsDisplay];
    }];
}

// Draw a black transluscent background with a spotlight circle opening
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context {
    // The auto-released UIColor object put into a CGColorRef object was causing a crash when loaded on a device
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0 alpha:0.6].CGColor);
    CGContextFillRect(context, layer.bounds);
    
    CGRect cirleRect = CGRectMake((self.spotPoint.x - self.spotRadius), (self.spotPoint.y - self.spotRadius), 180, 180);
    CGContextAddArc(context, self.spotPoint.x, self.spotPoint.y, self.spotRadius, 0.0, 2*M_PI, 0);
    CGContextClip(context);
    CGContextClearRect(context,cirleRect);
}

@end
