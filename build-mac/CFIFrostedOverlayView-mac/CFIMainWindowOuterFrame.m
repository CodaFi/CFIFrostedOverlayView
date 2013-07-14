//
//  CFIMainWindowOuterFrame.m
//  CFIFrostedOverlayView-mac
//
//  Created by Robert Widmann on 7/14/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFIMainWindowOuterFrame.h"
#import "CFIFrostedOverlayView.h"

@implementation CFIMainWindowOuterFrame

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];

	self.layer = CALayer.layer;
	self.layer.backgroundColor = NSColor.blackColor.CGColor;
	self.layer.cornerRadius = 15.f;
	self.wantsLayer = YES;
	
    return self;
}

- (BOOL)mouseDownCanMoveWindow {
	return YES;
}

@end
