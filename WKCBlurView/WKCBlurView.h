//
//  WKCBlurView.h
//  QuizYard
//
//  Created by WeiKunChao on 2019/5/30.
//  Copyright © 2019 QuizYard. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 模式

 - WKCBlurViewModeLight: 白
 - WKCBlurViewModeExtreLight: 加重白
 - WKCBlurViewModeDark: 黑
 - WKCBlurViewModeExtreDark: 加重黑
 */
typedef NS_ENUM(NSInteger, WKCBlurViewMode) {
    WKCBlurViewModeLight = 0,
    WKCBlurViewModeExtreLight = 1,
    WKCBlurViewModeDark = 2,
    WKCBlurViewModeExtreDark = 3,
};


// 高斯模糊视图
// MARK 注: blurView需要添加覆盖到要被模糊的视图上
//
@interface WKCBlurView : UIView

// 类型
@property (nonatomic, assign) WKCBlurViewMode model;
// 是否开启时时模糊, 默认开启. (模糊完,关闭,不然会很卡).
@property (nonatomic, assign) BOOL renderStatic;
// 模糊系数 (0 , 1) (0不模糊,1全模糊)
@property (nonatomic, assign) CGFloat blurRadius;
// 自定义颜色
@property (nonatomic, strong) UIColor * blurColor;

+ (instancetype)blurWithMode:(WKCBlurViewMode)mode;
- (instancetype)initWithMode:(WKCBlurViewMode)mode;

@end

