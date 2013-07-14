//
//  CFIAppDelegate.h
//  CFIFrostedOverlayView
//
//  Created by Robert Widmann on 6/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CFIViewController;

@interface CFIAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CFIViewController *mainViewController;

@end
