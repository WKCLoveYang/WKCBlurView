//
//  WKCBlurItemCell.h
//  WKCBlurView
//
//  Created by WeiKunChao on 2019/4/25.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKCBlurView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WKCBlurItemCell : UICollectionViewCell

@property (class, nonatomic, assign, readonly) CGSize itemSize;
@property (nonatomic, assign) WKCBlurType type;

@end

NS_ASSUME_NONNULL_END
