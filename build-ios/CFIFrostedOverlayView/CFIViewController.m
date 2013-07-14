//
//  CFIViewController.m
//  CFIFrostedOverlayView
//
//  Created by Robert Widmann on 6/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFIViewController.h"
#import "CFIControlCenterView.h"

@interface CFIViewController ()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIPanGestureRecognizer *bottomUpPanGestureRecognizer;
@property (nonatomic, strong) CFIControlCenterView *controlCenter;

@end

@implementation CFIViewController {
	float oldY, delta;
	BOOL allowPanning;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.backgroundImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
	self.backgroundImageView.image = [UIImage imageNamed:@"Wallpaper"];
	[self.view addSubview:self.backgroundImageView];
	
	self.controlCenter = [[CFIControlCenterView alloc]initWithFrame:CGRectOffset(CGRectInset(self.view.bounds, 0, 10), 0, CGRectGetHeight(self.view.bounds))];
	self.controlCenter.offset = 20.f;
	self.controlCenter.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self.view addSubview:self.controlCenter];
	self.controlCenter.viewToBlur = self.view;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];
	CGPoint touchLocation = [(UITouch *)[touches anyObject] locationInView:self.view];
	BOOL intersectsBottom = CGRectContainsPoint((CGRect){ .origin.y = CGRectGetHeight(self.view.bounds) - 10, .size.width = CGRectGetWidth(self.view.bounds), .size.height = 10 }, touchLocation);
	BOOL intersectsTop = CGRectContainsPoint(self.controlCenter.frame, touchLocation);
	allowPanning = intersectsBottom | intersectsTop;
	if (allowPanning) {
		oldY = touchLocation.y;
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesMoved:touches withEvent:event];
	if (allowPanning) {
		CGPoint touchLocation = [(UITouch *)[touches anyObject] locationInView:self.view];
		if (touchLocation.y > 20) {
			delta = touchLocation.y - oldY;
			CGRect newFrame = self.controlCenter.frame;
			newFrame.origin.y = touchLocation.y;
			self.controlCenter.frame = newFrame;
		}
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesEnded:touches withEvent:event];
	if (allowPanning) {
		[UIView animateWithDuration:0.3 delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
			CGRect frame = self.controlCenter.frame;
			frame.origin.y = (delta <= 0) ? 20  : CGRectGetHeight(self.view.bounds);
			[self.controlCenter setFrame:frame];
		} completion:^(BOOL finished) {
			
		}];
	}
	allowPanning = NO;
}

- (void)viewWillLayoutSubviews {
	self.backgroundImageView.frame = self.view.bounds;
}

@end
