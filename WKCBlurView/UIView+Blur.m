//
//  UIView+Blur.m
//  WKCBlurView
//
//  Created by WeiKunChao on 2019/4/25.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "UIView+Blur.h"
#import <objc/runtime.h>

static NSString * const WKCBlurTypeKey = @"wkc.blur.type";
static NSString * const WKCBlurShowKey = @"wkc.blur.show";
UIViewBlurType _bType = UIViewBlurTypeDark;

@implementation UIView (Blur)

- (void)setBlurType:(UIViewBlurType)blurType
{
    _bType = blurType;
    
    objc_setAssociatedObject(self, &WKCBlurTypeKey, [NSString stringWithFormat:@"%ld", blurType], OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    WKCBlurView * blur = nil;
    
    for (UIView * sub in self.subviews)
    {
        if ([sub isKindOfClass:WKCBlurView.class])
        {
            blur = (WKCBlurView *)sub;
            blur.blurType = (WKCBlurType)blurType;
            [blur startBlur];
        }
    }
    
    if (!blur)
    {
        blur = [[WKCBlurView alloc] init];
        blur.contentView = self;
        blur.blurType = (WKCBlurType)blurType;
        [blur startBlur];
        
        [self addSubview:blur];
        
        NSLayoutConstraint * top = [NSLayoutConstraint constraintWithItem:blur
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1.0
                                                                 constant:0];
        
        NSLayoutConstraint * bottom = [NSLayoutConstraint constraintWithItem:blur
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.0
                                                                    constant:0];
        
        NSLayoutConstraint * leading = [NSLayoutConstraint constraintWithItem:blur
                                                                    attribute:NSLayoutAttributeLeading
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self
                                                                    attribute:NSLayoutAttributeLeading
                                                                   multiplier:1.0
                                                                     constant:0];
        
        NSLayoutConstraint * traing = [NSLayoutConstraint constraintWithItem:blur
                                                                   attribute:NSLayoutAttributeTrailing
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeTrailing
                                                                  multiplier:1.0
                                                                    constant:0];
        
        [self addConstraint:top];
        [self addConstraint:bottom];
        [self addConstraint:leading];
        [self addConstraint:traing];
    }
}

- (UIViewBlurType)blurType
{
    return [objc_getAssociatedObject(self, &WKCBlurTypeKey) integerValue];
}

- (void)setShouldShowBlur:(BOOL)shouldShowBlur
{
    objc_setAssociatedObject(self, &WKCBlurShowKey, @(shouldShowBlur), OBJC_ASSOCIATION_ASSIGN);
    
    if (!shouldShowBlur)
    {
        for (UIView * sub in self.subviews)
        {
            if ([sub isKindOfClass:WKCBlurView.class])
            {
                [sub removeFromSuperview];
            }
        }
    }
    else
    {
        WKCBlurView * blur = nil;
        
        for (UIView * sub in self.subviews)
        {
            if ([sub isKindOfClass:WKCBlurView.class])
            {
                blur = (WKCBlurView *)sub;
            }
        }
        
        if (!blur)
        {
            self.blurType = _bType;
        }
    }
}

- (BOOL)shouldShowBlur
{
    return [objc_getAssociatedObject(self, &WKCBlurShowKey) boolValue];
}

@end
