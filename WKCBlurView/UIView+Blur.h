//
//  UIView+Blur.h
//  WKCBlurView
//
//  Created by WeiKunChao on 2019/4/25.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKCBlurView.h"

typedef NS_ENUM(NSInteger, UIViewBlurType) {
    UIViewBlurTypeLight,
    UIViewBlurTypeExtraLight,
    UIViewBlurTypeDark,
    UIViewBlurTypeExtraDark
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Blur)

// 注意调用顺序, 避免图层遮盖

@property (nonatomic, assign) BOOL shouldShowBlur;
@property (nonatomic, assign) UIViewBlurType blurType;

@end

NS_ASSUME_NONNULL_END
