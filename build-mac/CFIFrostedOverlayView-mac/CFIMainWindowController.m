//
//  CFIMainWindowController.m
//  CFIFrostedOverlayView-mac
//
//  Created by Robert Widmann on 7/14/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFIMainWindowController.h"
#import "CFIMainWindow.h"

@interface CFIMainWindowController ()

@end

@implementation CFIMainWindowController

- (id)init {
	self = [super init];
	
	self.window = [[CFIMainWindow alloc]initWithContentRect:(NSRect){ .size = { 716, 1210 } } styleMask:(NSBorderlessWindowMask) backing:NSBackingStoreRetained defer:NO];
	[self.window center];
	
	return self;
}


@end
