//
//  WKCBlurView.m
//  QuizYard
//
//  Created by WeiKunChao on 2019/5/30.
//  Copyright © 2019 QuizYard. All rights reserved.
//

#import "WKCBlurView.h"
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

@interface UIImage (Blur)

- (UIImage*)drn_boxblurImageWithBlur:(CGFloat)blur;

@end

@implementation UIImage (Blur)

- (UIImage*)drn_boxblurImageWithBlur:(CGFloat)blur
{
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //create vImage_Buffer for output
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];

    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    
    
    return returnImage;
}


@end





@interface WKCBlurViewManager : NSObject

@property (nonatomic, strong) NSMutableArray *views;

+ (id)sharedManager;

- (void)registerView:(WKCBlurView *)view;
- (void)deregisterView:(WKCBlurView *)view;

@end


@interface WKCBlurView()

@property (nonatomic, strong) UIView *tintView;

- (void)renderLayerWithView:(UIView*)superview;

@end











@implementation WKCBlurViewManager

+ (id)sharedManager
{
    static WKCBlurViewManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WKCBlurViewManager alloc] init];
    });
    
    return instance;
}

- (id)init
{
    if (self = [super init])
        self.views = [@[] mutableCopy];
    
    return self;
}



- (void)registerView:(WKCBlurView *)view
{
    if (![self.views containsObject:view]) [self.views addObject:view];
    [self refresh];
}

- (void)deregisterView:(WKCBlurView *)view
{
    [self.views removeObject:view];
    [self refresh];
}

- (void)refresh
{
    if (!self.views.count) return;
    
    for (WKCBlurView *view in self.views)
        [view renderLayerWithView:view.superview];
    
    double delayInSeconds = self.views.count * (1/30.f);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self refresh];
    });
}

@end





@implementation WKCBlurView

+ (instancetype)blurWithMode:(WKCBlurViewMode)mode
{
    WKCBlurView * blur = [[WKCBlurView alloc] initWithMode:mode];
    return blur;
}

- (instancetype)initWithMode:(WKCBlurViewMode)mode
{
    if (self = [super init]) {
        [self setupParams];
        switch (mode) {
            case WKCBlurViewModeLight:
                self.blurColor = [UIColor.whiteColor colorWithAlphaComponent:0.1];
                break;
            case WKCBlurViewModeExtreLight:
                self.blurColor = [UIColor.whiteColor colorWithAlphaComponent:0.5];
                break;
                
            case WKCBlurViewModeDark:
                self.blurColor = [UIColor.blackColor colorWithAlphaComponent:0.15];
                break;
                
            case WKCBlurViewModeExtreDark:
                self.blurColor = [UIColor.blackColor colorWithAlphaComponent:0.5];
                break;
                
            default:
                break;
        }
    }
    
    return self;
}

- (void)setupParams
{
    self.blurRadius = 1.0;
    
    self.tintView = [[UIView alloc] init];
    
    self.blurColor = [UIColor clearColor];
    
    [self addSubview:self.tintView];
    [self addTintviewLayout];
    
    self.clipsToBounds = YES;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupParams];
    }
    return self;
}

- (void)addTintviewLayout
{
    _tintView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint * top = [NSLayoutConstraint constraintWithItem:_tintView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint * bottom = [NSLayoutConstraint constraintWithItem:_tintView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint * leading = [NSLayoutConstraint constraintWithItem:_tintView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint * traing = [NSLayoutConstraint constraintWithItem:_tintView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    [self addConstraint:top];
    [self addConstraint:bottom];
    [self addConstraint:leading];
    [self addConstraint:traing];
}

- (void)dealloc
{
    [[WKCBlurViewManager sharedManager] deregisterView:self];
}


- (void)setRenderStatic:(BOOL)renderStatic
{
    _renderStatic = renderStatic;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (renderStatic)
            [[WKCBlurViewManager sharedManager] deregisterView:self];
        else
            [[WKCBlurViewManager sharedManager] registerView:self];
    });
}

- (void)setBlurColor:(UIColor *)blurColor
{
    _blurColor = blurColor;
    self.tintView.backgroundColor = _blurColor;
    [self.tintView setNeedsDisplay];
}


- (void)willMoveToSuperview:(UIView*)superview
{
    [self renderLayerWithView:superview];
}

- (void)didMoveToSuperview
{
    if (nil != self.superview) {
        
        if (!self.renderStatic)
            [[WKCBlurViewManager sharedManager] registerView:self];
    } else {
        
        [[WKCBlurViewManager sharedManager] deregisterView:self];
    }
}

- (void)renderLayerWithView:(UIView*)superview
{
    CGRect visibleRect = [superview convertRect:self.frame toView:self];
    visibleRect.origin.y += self.frame.origin.y;
    visibleRect.origin.x += self.frame.origin.x;
    
    CGFloat alpha = self.alpha;
    [self toggleBlurViewsInView:superview hidden:YES alpha:alpha];
    
    UIGraphicsBeginImageContextWithOptions(visibleRect.size, NO, 1.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, -visibleRect.origin.x, -visibleRect.origin.y);
    CALayer *layer = superview.layer;
    [layer renderInContext:context];

    [self toggleBlurViewsInView:superview hidden:NO alpha:alpha];
    
    __block UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{

        NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
        image = [[UIImage imageWithData:imageData] drn_boxblurImageWithBlur:self.blurRadius];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.layer.contents = (id)image.CGImage;
        });
    });
}

- (void)toggleBlurViewsInView:(UIView*)view hidden:(BOOL)hidden alpha:(CGFloat)originalAlpha
{
    for (UIView *subview in view.subviews)
        if ([subview isKindOfClass:WKCBlurView.class])
            subview.alpha = hidden ? 0.f : originalAlpha;
}


@end
