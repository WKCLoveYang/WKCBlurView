//
//  WKCBlueView.h
//  SecretLisa
//
//  Created by wkcloveYang on 2019/6/28.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const WKCBlurViewQualityDefault;
UIKIT_EXTERN NSString * const WKCBlurViewQualityLow;


typedef NS_ENUM(NSInteger, WKCBlurMode) {
    WKCBlurModeLight = 0,
    WKCBlurModeExtraLight = 1,
    WKCBlurModeDark = 2,
    WKCBlurModeExtraDark
};

@interface WKCBlurView : UIView

@property (nonatomic, strong) NSString *blurQuality;
@property (nonatomic, assign) CGFloat blurRadius; //模糊程度
@property (nonatomic, assign) CGRect blurCroppingRect; //模糊区域
@property (nonatomic, strong) UIColor * blurColor;

+ (instancetype)blurWithMode:(WKCBlurMode)mode;
- (instancetype)initWithMode:(WKCBlurMode)mode;

@end

