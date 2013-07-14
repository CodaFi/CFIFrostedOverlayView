//
//  CFIMainContentView.m
//  CFIFrostedOverlayView-mac
//
//  Created by Robert Widmann on 7/14/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFIMainContentView.h"
#import "CFIFrostedOverlayView.h"

@interface CFIMainContentView ()
@property (nonatomic, strong) CFIFrostedOverlayView *controlCenter;
@end

@implementation CFIMainContentView {
	float oldY, delta;
	BOOL allowPanning;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
	
	self.layer = CALayer.layer;
	self.layer.masksToBounds = YES;
	self.layer.backgroundColor = NSColor.whiteColor.CGColor;
	self.layer.cornerRadius = 5.f;
	self.layer.contents = [NSImage imageNamed:@"Wallpaper.png"];
	self.wantsLayer = YES;

	self.controlCenter = [[CFIFrostedOverlayView alloc]initWithFrame:CGRectOffset(CGRectInset(self.bounds, 0, 22), 0, -CGRectGetHeight(self.bounds) + 22)];
	self.controlCenter.offset = 22.f;
	[self addSubview:self.controlCenter];
	self.controlCenter.viewToBlur = self;
	
    return self;
}

- (void)mouseDown:(NSEvent *)theEvent {
	[super mouseDown:theEvent];
	CGPoint touchLocation = [self convertPoint:[self.window convertScreenToBase:[NSEvent mouseLocation]] fromView:nil];
	BOOL intersectsBottom = CGRectContainsPoint((CGRect){ .origin.y = 0, .size.width = CGRectGetWidth(self.bounds), .size.height = 10 }, touchLocation);
	BOOL intersectsTop = CGRectContainsPoint(self.controlCenter.frame, touchLocation);
	allowPanning = intersectsBottom | intersectsTop;
	if (allowPanning) {
		oldY = touchLocation.y;
	}
}

- (void)mouseDragged:(NSEvent *)theEvent {
	[super mouseDragged:theEvent];
	if (allowPanning) {
		CGPoint touchLocation = [self convertPoint:[self.window convertScreenToBase:[NSEvent mouseLocation]] fromView:nil];
		if (touchLocation.y < CGRectGetHeight(self.frame) - 44) {
			delta = touchLocation.y - oldY;
			CGRect newFrame = self.controlCenter.frame;
			newFrame.origin.y = touchLocation.y - CGRectGetHeight(self.frame) + 44;
			self.controlCenter.frame = newFrame;
		}
	}
}

- (void)mouseUp:(NSEvent *)theEvent {
	[super mouseUp:theEvent];
	if (allowPanning) {

//		[NSAnimationContext beginGrouping];
//		[[NSAnimationContext currentContext] setDuration:0.3f];
//		
		CGRect frame = self.controlCenter.frame;
		frame.origin.y = (delta <= 250) ? -CGRectGetHeight(self.bounds) - 22  : 0;
		[self.controlCenter setFrame:frame];
		
//		[NSAnimationContext endGrouping];
	}
	allowPanning = NO;
}


- (BOOL)mouseDownCanMoveWindow {
	return NO;
}

@end
