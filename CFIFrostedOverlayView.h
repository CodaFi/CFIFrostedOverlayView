//
//  CFIFrostedOverlayView.h
//  CFIFrostedOverlayView
//
//  Created by Robert Widmann on 6/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 * A control that renders its superview with a harsh gaussian blur, then overlays that with a tint
 * layer for customization, and further blur.  The defaults it's tuned with are meant to emulate
 * as much of the backing view of iOS 7's control center as possible.
 */
@interface CFIFrostedOverlayView : UIView

/**
 * The view that will be rendered by this control.  This must be set (else the control will default
 * to a bright white layer), and must not be set to nil.
 *
 * Every assignment to this property forces a re-rendering of the view, which is a *very* expensive
 * process, so it recommended that this property be set once, and updated only occaisionally when 
 * major elements have been brought onscreen.
 */
@property (nonatomic, weak) UIView *viewToBlur;

/**
 * An overlay layer provided as a convenience for setting the tint color of the control.
 * This property may be nil.
 */
@property (nonatomic, strong) CALayer *tintLayer;

/**
 * The offset of the top of the control to the top of the screen.  
 */
@property (nonatomic, assign) CGFloat offset;

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
