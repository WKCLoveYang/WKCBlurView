//
//  WKCBlurItemCell.m
//  WKCBlurView
//
//  Created by WeiKunChao on 2019/4/25.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "WKCBlurItemCell.h"

@interface WKCBlurItemCell()

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) WKCBlurView * blurView;
@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation WKCBlurItemCell

+ (CGSize)itemSize
{
    return CGSizeMake(UIScreen.mainScreen.bounds.size.width - 20 * 2, 300);
}

- (void)setType:(WKCBlurType)type
{
    _type = type;
    if (type == WKCBlurTypeCustom)
    {
        self.blurView.blurColor = [UIColor.redColor colorWithAlphaComponent:0.3];
    }
    else
    {
       self.blurView.blurType = type;
    }
    
    [self.blurView startBlur];
    
    if (type == WKCBlurTypeLight)
    {
        self.titleLabel.text = @"Light";
    }
    else if (type == WKCBlurTypeExtraLight)
    {
        self.titleLabel.text = @"ExtraLight";
    }
    else if (type == WKCBlurTypeDark)
    {
        self.titleLabel.text = @"Dark";
    }
    else if (type == WKCBlurTypeExtraDark)
    {
        self.titleLabel.text = @"ExtraDark";
    }
    else if (type == WKCBlurTypeCustom)
    {
        self.titleLabel.text = @"Custom";
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.contentView.layer.cornerRadius = 4;
        self.contentView.layer.masksToBounds = YES;
        
        [self wkc_addSubViews];
    }
    
    return self;
}

- (void)wkc_addSubViews
{
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.blurView];
    [self.contentView addSubview:self.titleLabel];
    
    NSLayoutConstraint * iTop = [NSLayoutConstraint constraintWithItem:_imageView
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.contentView
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.0
                                                              constant:0];
    
    NSLayoutConstraint * iBottom = [NSLayoutConstraint constraintWithItem:_imageView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.contentView
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.0
                                                              constant:0];
    
    NSLayoutConstraint * iLeading = [NSLayoutConstraint constraintWithItem:_imageView
                                                                attribute:NSLayoutAttributeLeading
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.contentView
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1.0
                                                                 constant:0];
    
    NSLayoutConstraint * iTraing = [NSLayoutConstraint constraintWithItem:_imageView
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:0];
    
    
    
    
    NSLayoutConstraint * bTop = [NSLayoutConstraint constraintWithItem:_blurView
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.contentView
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.0
                                                              constant:0];
    
    NSLayoutConstraint * bBottom = [NSLayoutConstraint constraintWithItem:_blurView
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.contentView
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1.0
                                                                 constant:0];
    
    NSLayoutConstraint * bLeading = [NSLayoutConstraint constraintWithItem:_blurView
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1.0
                                                                  constant:0];
    
    NSLayoutConstraint * bTraing = [NSLayoutConstraint constraintWithItem:_blurView
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.contentView
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0
                                                                 constant:0];
    
    
    NSLayoutConstraint * tCenterX = [NSLayoutConstraint constraintWithItem:_titleLabel
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.contentView
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.0
                                                              constant:0];
    
    NSLayoutConstraint * tCenterY = [NSLayoutConstraint constraintWithItem:_titleLabel
                                                                attribute:NSLayoutAttributeCenterY
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.contentView
                                                                attribute:NSLayoutAttributeCenterY
                                                               multiplier:1.0
                                                                 constant:0];

    [self.contentView addConstraint:iTop];
    [self.contentView addConstraint:iBottom];
    [self.contentView addConstraint:iLeading];
    [self.contentView addConstraint:iTraing];
    
    [self.contentView addConstraint:bTop];
    [self.contentView addConstraint:bBottom];
    [self.contentView addConstraint:bLeading];
    [self.contentView addConstraint:bTraing];
    
    [self.contentView addConstraint:tCenterX];
    [self.contentView addConstraint:tCenterY];
}


- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test.jpg"]];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _imageView;
}

- (WKCBlurView *)blurView
{
    if (!_blurView)
    {
        _blurView = [[WKCBlurView alloc] init];
        _blurView.contentView = self.imageView;
        _blurView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _blurView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UIColor.whiteColor;
        _titleLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightSemibold];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _titleLabel;
}

@end
