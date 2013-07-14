//
//  CFIAppDelegate.m
//  CFIFrostedOverlayView-mac
//
//  Created by Robert Widmann on 7/14/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFIAppDelegate.h"
#import "CFIMainWindowController.h"

@interface CFIAppDelegate ()
@property (nonatomic, strong) CFIMainWindowController *mainWindowController;
@end

@implementation CFIAppDelegate

- (id)init {
	self = [super init];
	
	self.mainWindowController = [[CFIMainWindowController alloc]init];

	return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	[self.mainWindowController showWindow:NSApp];
}

@end
