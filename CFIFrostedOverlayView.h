//
//  CFIFrostedOverlayView.h
//  CFIFrostedOverlayView
//
//  Created by Robert Widmann on 6/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import <Availability.h>

#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
	#import <AppKit/AppKit.h>
#elif defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
	#import <UIKit/UIKit.h>
#else
	#error "This control is incompatible with the current compilation target."
#endif

#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
	#if __MAC_OS_X_VERSION_MIN_REQUIRED > 1050
		#import <AppKit/AppKit.h>
	#else
		#error "This control is incompatible with the current compilation target."
	#endif
#elif defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
	#import <UIKit/UIKit.h>
#else
	#error "This control is incompatible with the current compilation target."
#endif

#ifndef CFI_FROSTED_OVERLAY_VIEWCLASS
	#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
		#if __MAC_OS_X_VERSION_MIN_REQUIRED > 1050
			#define CFI_FROSTED_OVERLAY_VIEWCLASS NSView
		#else
			#warning "Core Animation is required for this control."
		#endif
	#elif defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
		#define CFI_FROSTED_OVERLAY_VIEWCLASS UIView
	#else
		#error "This control is incompatible with the current compilation target."
	#endif
#endif

#ifndef CFI_FROSTED_OVERLAY_COLORCLASS
	#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
		#if __MAC_OS_X_VERSION_MIN_REQUIRED > 1050
			#define CFI_FROSTED_OVERLAY_COLORCLASS NSColor
		#else
			#warning "Core Animation is required for this control."
		#endif
	#elif defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
		#define CFI_FROSTED_OVERLAY_COLORCLASS UIColor
	#else
		#error "This control is incompatible with the current compilation target."
	#endif
#endif

/**
 * A control that renders its superview with a harsh gaussian blur, then overlays that with a tint
 * layer for customization, and further blur.  The defaults it's tuned with are meant to emulate
 * as much of the backing view of iOS 7's control center as possible.
 */
@interface CFIFrostedOverlayView : CFI_FROSTED_OVERLAY_VIEWCLASS

/**
 * The view that will be rendered by this control.  This must be set (else the control will default
 * to a bright white layer), and must not be set to nil.
 *
 * Every assignment to this property forces a re-rendering of the view, which is a *very* expensive
 * process, so it recommended that this property be set once, and updated only occaisionally when 
 * major elements have been brought onscreen.
 */
@property (nonatomic, weak) CFI_FROSTED_OVERLAY_VIEWCLASS *viewToBlur;

/**
 * An overlay layer provided as a convenience for setting the tint color of the control.
 * This property may be nil.
 */
@property (nonatomic, strong) CALayer *tintLayer;

/**
 * The offset of the top of the control to the top of the screen.  
 */
@property (nonatomic, assign) CGFloat offset;

#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
@property (nonatomic, strong) NSColor *backgroundColor;
#endif

@end


/**
 * A way to get around iOS' odd restriction that a view may only have one delegate (else demons fly
 * out of people's noses, and nobody wants that).  As a convenience, it comes with a drawRect block
 * that gets called in `-drawLayer:inContext:` for those who are so inclined to use it.  It's 
 * important to note that the class does not retain its layer in order to prevent retain cycles.
 */
typedef void(^CFILayerDelegateDrawRect)(id layer, CGContextRef context);

@interface CFILayerDelegate : NSObject {
    __weak CALayer *_layer;
}

/**
 * Initializes the reciever with a given layer.
 * The default initializer for this class.
 */
- (id)initWithLayer:(CALayer *)view;

/**
 * A block that gets executed in `-drawLayer:inContext:`.
 */
@property (nonatomic, copy) CFILayerDelegateDrawRect drawRect;

@end


/**
 * Le sigh.  This is fixed in OS [X-Dacted], but for now we have to make a category in order to
 * avoid doubling the #ifdefs for something as simple as colors.  If using these methods, you must
 * CFRelease() any primitives returned from them, as ARC totally broke the autoreleasing mechanism
 * in CG.
 */
#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED

@interface NSColor (CFIFrostedOverlayExtensions)

#if __MAC_OS_X_VERSION_MIN_REQUIRED < 1080
- (CGColorRef)CGColor CF_RETURNS_RETAINED;
#endif
#if __MAC_OS_X_VERSION_MIN_REQUIRED < 1090
+ (NSColor *)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha;
+ (NSColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
#endif

@end

#endif
