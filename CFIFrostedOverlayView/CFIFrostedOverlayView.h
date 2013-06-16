//
//  CFIFrostedOverlayView.h
//  CFIFrostedOverlayView
//
//  Created by Robert Widmann on 6/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CFILayerDelegateDrawRect)(id layer, CGContextRef context);

@interface CFIFrostedOverlayView : UIView

@property (nonatomic, weak) UIView *viewToBlur;
@property (nonatomic, strong) CALayer *tintLayer;
@property (nonatomic, assign) CGFloat offset;

@end

@interface CFILayerDelegate : NSObject {
    __weak CALayer *_layer;
}
- (id)initWithLayer:(CALayer *)view;
@property (nonatomic, copy) CFILayerDelegateDrawRect drawRect;
@end

