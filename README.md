Spotlight Overlay
====================
The spotlight overlay is useful in isolating specific aspects of an iPhone view with a spotlight effect.  The overlay puts a semi-transparent black background over the view that this overlay is added to, and puts a spotlight over whatever part of the view you want isolated.  In addition, there is a button that can be placed on the view that acts as a way to transition from one spotlight to the next (animated, of course).

### Usage
+ This project was built with ARC, for iOS 5
+ Import the view controller: #import "SpotlightViewController.h"
+ Have the view controller using this object conform to the SpotlightViewControllerDelegate protocol: UIViewController<SpotlightViewControllerDelegate>
+ Create the SpotlightViewController object, set the delegate, and add the view
+ Call animateSpotlight to set where you want the button to appear, where you want the spotlight to be, and the size (radius) of the spotlight

### Example

    // Create the spotlight overview, and set this class as the delegate
    self.spotlightViewController = [[SpotlightViewController alloc] init];
    [self.spotlightViewController setDelegate:self];
    [self.view addSubview:self.spotlightViewController.view];
    
    // Animate the spotlight to its first location
    // This call will set the frame of the button to CGRectMake(35, 80, 250, 60), with the text "Testing!".  It will place the spotlight center at point (150, 260), with a radius of 80 pts
    [self.spotlightViewController animateSpotlight:CGRectMake(35, 80, 250, 60) withButtonText:@"Testing!" withSpotlightCenter:CGPointMake(150, 260) withSpotlightRadius:80];

### Screenshot

![Spotlight in action](iphone-spotlight/Spotlight/spotlight-screenshot.png "Spotlight in action")
