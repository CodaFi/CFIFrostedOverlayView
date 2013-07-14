//
//  CFIFrostedOverlayView.m
//  CFIFrostedOverlayView
//
//  Created by Robert Widmann on 6/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFIFrostedOverlayView.h"
#import <QuartzCore/QuartzCore.h>
#if defined(UIKIT_EXTERN)
#import <GPUImage.h>
#endif

@implementation CFILayerDelegate
-(id) initWithLayer:(CALayer *)view {
    self = [super init];
	_layer = view;
	_layer.delegate = self;
    return self;
}
- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event { return (id)NSNull.null; }
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
	if (ctx == NULL) return;
	if (self.drawRect != NULL) self.drawRect(_layer, ctx);
}
@end

@interface CFIFrostedOverlayView ()
@property (nonatomic, strong) CFILayerDelegate *layerDelegate;
@property (nonatomic, strong) CALayer *blurredLayer;
@end

@implementation CFIFrostedOverlayView

- (id)init {
	return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
	self.layer = CALayer.layer;
	self.layer.masksToBounds = YES;
	self.wantsLayer = YES;
#endif
	
	self.backgroundColor = CFI_FROSTED_OVERLAY_COLORCLASS.whiteColor;
	
#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
	self.clipsToBounds = YES;
#endif
	
	self.blurredLayer = CALayer.layer;
	self.blurredLayer.frame = self.bounds;
#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
	CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
	[blurFilter setDefaults];
	[blurFilter setValue:@(5) forKey:@"inputRadius"];
	[blurFilter setName:@"blur"];
	self.blurredLayer.filters = @[ blurFilter ];
#endif
	[self.layer addSublayer:self.blurredLayer];
	
	self.layerDelegate = [[CFILayerDelegate alloc]initWithLayer:self.blurredLayer];
	
	self.tintLayer = [CALayer layer];
	self.tintLayer.frame = self.bounds;
	CGColorRef backgroundColor = [CFI_FROSTED_OVERLAY_COLORCLASS colorWithWhite:1.000 alpha:0.800].CGColor;
	[self.layer setBackgroundColor:backgroundColor];
	[self.layer addSublayer:self.tintLayer];
	
#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
#if __MAC_OS_X_VERSION_MIN_REQUIRED >= 1090
	CFRelease(backgroundColor);
#endif
#endif
	
	return self;
}

- (void)awakeFromNib {
	self.backgroundColor = CFI_FROSTED_OVERLAY_COLORCLASS.whiteColor;
#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
	self.clipsToBounds = YES;
#endif
	self.blurredLayer = CALayer.layer;
	self.blurredLayer.frame = self.bounds;
	[self.layer addSublayer:self.blurredLayer];
	
	self.layerDelegate = [[CFILayerDelegate alloc]initWithLayer:self.blurredLayer];
	
	self.tintLayer = [CALayer layer];
	self.tintLayer.frame = self.bounds;
	CGColorRef backgroundColor = [CFI_FROSTED_OVERLAY_COLORCLASS colorWithWhite:1.000 alpha:0.300].CGColor;
	[self.tintLayer setBackgroundColor:backgroundColor];
	[self.layer addSublayer:self.tintLayer];
	
#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
#if __MAC_OS_X_VERSION_MIN_REQUIRED >= 1090
	CFRelease(backgroundColor);
#endif
#endif
}

- (void)setViewToBlur:(CFI_FROSTED_OVERLAY_VIEWCLASS *)viewToBlur {
	_viewToBlur = viewToBlur;
#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
	__weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
		__strong __typeof(self) self = weakSelf;
        GPUImageGaussianBlurFilter *filter = [[GPUImageGaussianBlurFilter alloc] init];
        filter.blurSize = UIScreen.mainScreen.scale * 9;
		UIImage *image = CFIImageFromView(self.viewToBlur);
		self.blurredLayer.contents = (id)[filter imageByFilteringImage:image].CGImage;
    });
#elif defined (__MAC_OS_X_VERSION_MIN_REQUIRED)
	self.blurredLayer.contents = (__bridge id)CFIImageFromView(self.viewToBlur);
#endif
}

- (void)setFrame:(CGRect)frame {
	[super setFrame:frame];
#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
	CGRect convertedRect = [self convertRect:self.bounds fromView:self.superview];
	self.blurredLayer.frame = (CGRect){ .origin.y = convertedRect.origin.y, .size.height = CGRectGetHeight(self.viewToBlur.bounds) + self.offset, .size.width = frame.size.width };
	self.tintLayer.frame = self.bounds;
#elif defined (__MAC_OS_X_VERSION_MIN_REQUIRED)
	CGRect convertedRect = [self convertRect:self.bounds fromView:self.superview];
	self.blurredLayer.frame = (CGRect){ .origin.y = convertedRect.origin.y - (self.offset/2), .size.height = NSHeight(self.viewToBlur.bounds), .size.width = frame.size.width };
	self.tintLayer.frame = self.bounds;
#endif
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
	[self.backgroundColor ?: NSColor.whiteColor set];
	NSRectFill(rect);
#endif
}

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED

static UIImage *CFIImageFromView(UIView *view) {
	CGSize size = view.bounds.size;
    
    CGFloat scale = UIScreen.mainScreen.scale;
    size.width *= scale;
    size.height *= scale;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(ctx, scale, scale);
	
    [view.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#elif defined (__MAC_OS_X_VERSION_MIN_REQUIRED)

static CGImageRef CFIImageFromView(NSView *view) {
	CGSize size = view.bounds.size;
    
	NSBitmapImageRep * bir = [view bitmapImageRepForCachingDisplayInRect:view.bounds];
    [bir setSize:size];
	
    [view cacheDisplayInRect:view.bounds toBitmapImageRep:bir];
	
    NSImage *image = [[NSImage alloc] initWithSize:size];
    [image addRepresentation:bir];
    
	NSRect rect = NSRectFromCGRect(view.bounds);
    return [image CGImageForProposedRect:&rect context:nil hints:nil];
}

#endif

@end

#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED

@implementation NSColor (CFIFrostedOverlayExtensions)

#if __MAC_OS_X_VERSION_MIN_REQUIRED < 1080

- (CGColorRef)CGColor {
	NSColor *colorRGB = [self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
    CGFloat components[4];
    [colorRGB getRed:&components[0] green:&components[1] blue:&components[2] alpha:&components[3]];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    CGColorRef theColor = CGColorCreate(colorSpace, components);
    CGColorSpaceRelease(colorSpace);
    return theColor;
}
#endif

#if __MAC_OS_X_VERSION_MIN_REQUIRED < 1090
+ (NSColor *)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha {
	return [NSColor colorWithCalibratedWhite:white alpha:alpha];
}

+ (NSColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	return [NSColor colorWithRed:red green:green blue:blue alpha:alpha];
}
#endif

@end
#endif
