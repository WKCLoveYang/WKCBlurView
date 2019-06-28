//
//  WKCBlueView.m
//  SecretLisa
//
//  Created by wkcloveYang on 2019/6/28.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "WKCBlurView.h"
#import <QuartzCore/QuartzCore.h>

@interface CABackdropLayer : CALayer

@end

@interface CAFilter : NSObject

+ (instancetype)filterWithName:(NSString *)name;

@end



UIKIT_EXTERN NSString * const kCAFilterGaussianBlur;
NSString * const WKCBlurViewQualityDefault = @"default";
NSString * const WKCBlurViewQualityLow = @"low";
static NSString * const WKCBlurViewQualityKey = @"inputQuality";
static NSString * const WKCBlurViewRadiusKey = @"inputRadius";
static NSString * const WKCBlurViewBoundsKey = @"inputBounds";
static NSString * const WKCBlurViewHardEdgesKey = @"inputHardEdges";


@interface WKCBlurView()

@property (weak, nonatomic) CAFilter *blurFilter;
@property (nonatomic, assign) BOOL blurEdges;
@property (nonatomic, assign) WKCBlurMode mode;
@end



@implementation WKCBlurView

+ (instancetype)blurWithMode:(WKCBlurMode)mode
{
    return [[WKCBlurView alloc] initWithMode:mode];
}

- (instancetype)initWithMode:(WKCBlurMode)mode
{
    if (self = [super init]) {
        _mode = mode;
        
        CAFilter *filter = [CAFilter filterWithName:kCAFilterGaussianBlur];
        self.layer.filters = @[filter];
        self.blurFilter = filter;
        
        self.blurQuality = WKCBlurViewQualityDefault;
        self.blurRadius = 10.0f;
        self.blurEdges = YES;
        
        switch (mode) {
            case WKCBlurModeExtraLight:
            {
                self.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.5];
            }
                break;
                
            case WKCBlurModeDark:
            {
                self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.2];
            }
                break;
                
            case WKCBlurModeExtraDark:
            {
                self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.5];
            }
                break;
                
            default:
                break;
        }
    }
    
    return self;
}

+ (Class)layerClass {
    return [CABackdropLayer class];
}


- (void)setQuality:(NSString *)quality {
    [self.blurFilter setValue:quality forKey:WKCBlurViewQualityKey];
}

- (NSString *)quality {
    return [self.blurFilter valueForKey:WKCBlurViewQualityKey];
}

- (void)setBlurRadius:(CGFloat)radius {
    [self.blurFilter setValue:@(radius) forKey:WKCBlurViewRadiusKey];
}

- (CGFloat)blurRadius {
    return [[self.blurFilter valueForKey:WKCBlurViewRadiusKey] floatValue];
}

- (void)setBlurCroppingRect:(CGRect)croppingRect {
    [self.blurFilter setValue:[NSValue valueWithCGRect:croppingRect] forKey:WKCBlurViewBoundsKey];
}

- (CGRect)blurCroppingRect {
    NSValue *value = [self.blurFilter valueForKey:WKCBlurViewBoundsKey];
    return value ? [value CGRectValue] : CGRectNull;
}

- (void)setBlurEdges:(BOOL)blurEdges {
    [self.blurFilter setValue:@(!blurEdges) forKey:WKCBlurViewHardEdgesKey];
}

- (BOOL)blurEdges {
    return ![[self.blurFilter valueForKey:WKCBlurViewHardEdgesKey] boolValue];
}

- (void)setBlurColor:(UIColor *)blurColor
{
    _blurColor = blurColor;
    self.backgroundColor = blurColor;
}

@end
