//
//  CFIControlCenterView.m
//  CFIFrostedOverlayView
//
//  Created by Robert Widmann on 6/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFIControlCenterView.h"
#import "CFIControlCenterSquareButton.h"
#import "CFIControlCenterCircleButton.h"
#import "EXTScope.h"

@interface CFIControlCenterView ()

@property (nonatomic, strong) CFIControlCenterSquareButton *flashLightButton;
@property (nonatomic, strong) CFIControlCenterSquareButton *stopwatchButton;
@property (nonatomic, strong) CFIControlCenterSquareButton *calculatorButton;
@property (nonatomic, strong) CFIControlCenterSquareButton *cameraButton;

@property (nonatomic, strong) CFIControlCenterCircleButton *airplaneModeButton;
@property (nonatomic, strong) CFIControlCenterCircleButton *wifiButton;
@property (nonatomic, strong) CFIControlCenterCircleButton *bluetoothButton;
@property (nonatomic, strong) CFIControlCenterCircleButton *doNotDisturbButton;
@property (nonatomic, strong) CFIControlCenterCircleButton *rotationLockButton;

@property (nonatomic, strong) UISlider *brightnessSlider;


@property (nonatomic, strong) CFILayerDelegate *tintLayerDelegate;

@end

@implementation CFIControlCenterView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	_flashLightButton = [[CFIControlCenterSquareButton alloc]initWithFrame:(CGRect){ .origin.y = CGRectGetHeight(self.bounds) - 70, .origin.x = 25, .size = { 50, 50 } }];
	_stopwatchButton = [[CFIControlCenterSquareButton alloc]initWithFrame:(CGRect){ .origin.y = CGRectGetHeight(self.bounds) - 70, .origin.x = 100, .size = { 50, 50 } }];
	_calculatorButton = [[CFIControlCenterSquareButton alloc]initWithFrame:(CGRect){ .origin.y = CGRectGetHeight(self.bounds) - 70, .origin.x = 175, .size = { 50, 50 } }];
	_cameraButton = [[CFIControlCenterSquareButton alloc]initWithFrame:(CGRect){ .origin.y = CGRectGetHeight(self.bounds) - 70, .origin.x = 250, .size = { 50, 50 } }];
	
	_airplaneModeButton = [[CFIControlCenterCircleButton alloc]initWithFrame:(CGRect){ .origin.y = 40, .origin.x = 30, .size = { 40, 40 } }];
	_wifiButton = [[CFIControlCenterCircleButton alloc]initWithFrame:(CGRect){ .origin.y = 40, .origin.x = 85, .size = { 40, 40 } }];
	_bluetoothButton = [[CFIControlCenterCircleButton alloc]initWithFrame:(CGRect){ .origin.y = 40, .origin.x = 140, .size = { 40, 40 } }];
	_doNotDisturbButton = [[CFIControlCenterCircleButton alloc]initWithFrame:(CGRect){ .origin.y = 40, .origin.x = 195, .size = { 40, 40 } }];
	_rotationLockButton = [[CFIControlCenterCircleButton alloc]initWithFrame:(CGRect){ .origin.y = 40, .origin.x = 250, .size = { 40, 40 } }];

	_brightnessSlider = [[UISlider alloc]initWithFrame:(CGRect){ .origin.y = 96, .origin.x = 48, .size = { 220, 32 } }];
	_brightnessSlider.minimumTrackTintColor = UIColor.whiteColor;
	_brightnessSlider.maximumTrackTintColor = UIColor.blackColor;

	[self addSubview:_flashLightButton];
	[self addSubview:_stopwatchButton];
	[self addSubview:_calculatorButton];
	[self addSubview:_cameraButton];

	[self addSubview:_airplaneModeButton];
	[self addSubview:_wifiButton];
	[self addSubview:_bluetoothButton];
	[self addSubview:_doNotDisturbButton];
	[self addSubview:_rotationLockButton];

	[self addSubview:_brightnessSlider];

	_tintLayerDelegate = [[CFILayerDelegate alloc]initWithLayer:self.tintLayer];
	@weakify(self);
	_tintLayerDelegate.drawRect = ^(CALayer *layer, CGContextRef currentContext) {
		@strongify(self);
		CGRect b = self.bounds;
		CGContextSetStrokeColor(currentContext, (CGFloat[4]){ 0.f, 0.f, 0.f, 1.f });
		CGContextSetLineWidth(currentContext, 2.f);
		CGContextMoveToPoint(currentContext, 0, 94);
		CGContextAddLineToPoint(currentContext, CGRectGetWidth(b), 94);
		CGContextStrokePath(currentContext);
		
		CGContextSetLineWidth(currentContext, 2.f);
		CGContextMoveToPoint(currentContext, 0, 130);
		CGContextAddLineToPoint(currentContext, CGRectGetWidth(b), 130);
		CGContextStrokePath(currentContext);
		
		CGContextBeginPath(currentContext);
		CGContextMoveToPoint(currentContext, 0, CGRectGetHeight(self.bounds) - 90);
		CGContextAddLineToPoint(currentContext, CGRectGetWidth(b), CGRectGetHeight(self.bounds) - 90);
		CGContextStrokePath(currentContext);
	};
	return self;
}

- (void)drawRect:(CGRect)rect {
	[self.tintLayer setNeedsDisplay];
	[super drawRect:rect];
}

@end
