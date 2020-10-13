//
//  RentSelectImageView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/25.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentSelectImageView : UIView<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
#pragma mark property datas
@property (nonatomic, strong) NSMutableArray *aryDatas;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIView *viewBG;



@end


@interface RentCollectionCell : UICollectionViewCell
@property  (nonatomic, strong) UIImageView *ivImage;
#pragma mark 获取cell高度
+ (CGSize)fetchHeight;
#pragma mark 刷新cell
- (CGSize)resetCellWithModel:(ModelImage *)model;
- (void)resetCellWithCamera;

@end
