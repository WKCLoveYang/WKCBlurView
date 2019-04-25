//
//  ViewController.m
//  WKCBlurView
//
//  Created by WeiKunChao on 2019/4/25.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "ViewController.h"
#import "WKCBlurItemCell.h"

@interface ViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSArray <NSNumber *> * dataSource;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark -UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WKCBlurItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(WKCBlurItemCell.class) forIndexPath:indexPath];
    cell.type = self.dataSource[indexPath.row].integerValue;
    return cell;
}



#pragma mark - Property
- (NSArray<NSNumber *> *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = @[
                        @(WKCBlurTypeLight),
                        @(WKCBlurTypeDark),
                        @(WKCBlurTypeExtraLight),
                        @(WKCBlurTypeExtraDark),
                        @(WKCBlurTypeCustom)
                        ];
    }
    
    return _dataSource;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 15;
        layout.minimumInteritemSpacing = 15;
        layout.itemSize = WKCBlurItemCell.itemSize;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) collectionViewLayout:layout];
        _collectionView.contentInset = UIEdgeInsetsMake(20, 20, 30, 20);
        _collectionView.backgroundView = nil;
        _collectionView.backgroundColor = nil;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:WKCBlurItemCell.class forCellWithReuseIdentifier:NSStringFromClass(WKCBlurItemCell.class)];
    }
    
    return _collectionView;
}

@end
