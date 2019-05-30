//
//  WKCBlurView.h
//  QuizYard
//
//  Created by WeiKunChao on 2019/5/30.
//  Copyright © 2019 QuizYard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKCBlurView : UIView

// 是否开启时时模糊, 默认开启. (模糊完,关闭,不然会很卡).
@property (nonatomic, assign) BOOL renderStatic;
// 模糊系数
@property (nonatomic, assign) CGFloat blurRadius;
// 自定义颜色
@property (nonatomic, strong) UIColor * tint;

@end

