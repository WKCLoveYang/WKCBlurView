//
//  WKCBlurView.h
//  ddasd
//
//  Created by WeiKunChao on 2019/4/22.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WKCBlurType) {
    WKCBlurTypeLight = 0,
    WKCBlurTypeExtraLight,
    WKCBlurTypeDark,
    WKCBlurTypeExtraDark,
    WKCBlurTypeCustom
};

@interface WKCBlurView : UIView

@property (nonatomic, assign) WKCBlurType blurType; //模糊类型
@property (nonatomic, assign) CGFloat blurRadius; //自定义模糊程度
@property (nonatomic, strong) UIColor * blurColor; //自定义一个模糊颜色
@property (nonatomic, strong) UIView * contentView; //要蒙的视图

- (void)startBlur; //开始

@end

