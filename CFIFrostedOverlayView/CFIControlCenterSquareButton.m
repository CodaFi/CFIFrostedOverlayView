//
//  CFIControlCenterSquareButton.m
//  CFIFrostedOverlayView
//
//  Created by Robert Widmann on 6/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFIControlCenterSquareButton.h"

@implementation CFIControlCenterSquareButton

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	self.layer.borderWidth = 1.f;
	self.layer.borderColor = UIColor.blackColor.CGColor;
	self.layer.cornerRadius = 8;
	
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];
	
	self.layer.borderColor = UIColor.whiteColor.CGColor;
	[self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesEnded:touches withEvent:event];
	
	self.layer.borderColor = UIColor.blackColor.CGColor;
	[self setNeedsDisplay];
}

@end
