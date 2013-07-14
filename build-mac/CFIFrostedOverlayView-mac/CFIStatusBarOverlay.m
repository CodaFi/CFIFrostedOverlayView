//
//  CFIStatusBarOverlay.m
//  CFIFrostedOverlayView-mac
//
//  Created by Robert Widmann on 7/14/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFIStatusBarOverlay.h"
#import <CoreText/CoreText.h>

@implementation CFIStatusBarOverlay

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
	
	self.layer = CALayer.layer;
	self.layer.backgroundColor = NSColor.blackColor.CGColor;
	self.layer.opacity = 0.5f;
	self.wantsLayer = YES;
    
	CALayer *batteryIndicatorLayer = CALayer.layer;
	batteryIndicatorLayer.contents = [NSImage imageNamed:@"BatteryIndicator.png"];
	batteryIndicatorLayer.frame = (NSRect){ .origin.x = 580, .origin.y = 12, .size.width = 50, .size.height = 22 };
	[self.layer addSublayer:batteryIndicatorLayer];
	
	CATextLayer *timeLayer = CATextLayer.layer;
	CTFontRef font = CTFontCreateWithName(CFSTR("HelveticaNeue-Medium"), 11, NULL);
	timeLayer.font = font;
	timeLayer.fontSize = 20.f;
	timeLayer.foregroundColor = NSColor.whiteColor.CGColor;
	timeLayer.string = CFICurrentTimeString();
	timeLayer.frame = (NSRect){ .origin.x = 280, .size.height = NSHeight(frame) - 4, .size.width = 300 };
	[self.layer addSublayer:timeLayer];
	
	
	CATextLayer *carrierLayer = CATextLayer.layer;
	carrierLayer.font = font;
	carrierLayer.fontSize = 20.f;
	carrierLayer.foregroundColor = NSColor.whiteColor.CGColor;
	carrierLayer.string = @"Carrier";
	carrierLayer.frame = (NSRect){ .origin.x = 10, .size.height = NSHeight(frame) - 4, .size.width = 300 };
	[self.layer addSublayer:carrierLayer];
	
	CALayer *wifiIconLayer = CALayer.layer;
	wifiIconLayer.contents = [NSImage imageNamed:@"WiFi-Icon.png"];
	wifiIconLayer.frame = (NSRect){ .origin.x = 82, .origin.y = 15, .size.width = 23, .size.height = 18 };
	[self.layer addSublayer:wifiIconLayer];
	
	CFRelease(font);
	
    return self;
}


static NSString *CFICurrentTimeString(void) {
	static NSDateFormatter *timeFormatter = nil;
	if (timeFormatter == nil) {
		timeFormatter = [[NSDateFormatter alloc]init];
		[timeFormatter setDateFormat:@"hh:mm a"];
	}
	
	NSString *timeString = [timeFormatter stringFromDate:[NSDate date]];
	if ([timeString hasPrefix:@"0"]) {
		return [timeString substringFromIndex:1];
	}
	return timeString;
}

@end
