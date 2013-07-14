//
//  CFIMainWindow.m
//  CFIFrostedOverlayView-mac
//
//  Created by Robert Widmann on 7/14/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFIMainWindow.h"
#import "CFIMainWindowOuterFrame.h"
#import "CFIMainContentView.h"
#import "CFIStatusBarOverlay.h"

@implementation CFIMainWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
	self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag];
	
	CFIMainWindowOuterFrame *outerFrame = [[CFIMainWindowOuterFrame alloc]initWithFrame:contentRect];
	[self.contentView addSubview:outerFrame];
	
	CFIMainContentView *contentView = [[CFIMainContentView alloc]initWithFrame:NSInsetRect(outerFrame.bounds, 38, 38)];
	[outerFrame addSubview:contentView];
	
	CFIStatusBarOverlay *overlay = [[CFIStatusBarOverlay alloc]initWithFrame:(NSRect){ .origin.y = NSHeight(contentView.frame) - 40, .size.width = NSWidth(contentView.frame), .size.height = 40.f }];
	[contentView addSubview:overlay];

	return self;
}

- (BOOL)isMovableByWindowBackground {
	return YES;
}

@end
