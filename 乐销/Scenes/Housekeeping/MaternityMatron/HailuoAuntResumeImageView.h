//
//  HailuoAppointmentImageView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/17.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HailuoAuntResumeImageView : UIView<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
#pragma mark property datas
@property (nonatomic, strong) NSMutableArray *aryDatas;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) UILabel *title;
@end


@interface HailuoAppointmentCollectionCell : UICollectionViewCell
@property  (nonatomic, strong) UIImageView *ivImage;
#pragma mark 获取cell高度
+ (CGSize)fetchHeight;
#pragma mark 刷新cell
- (CGSize)resetCellWithModel:(ModelImage *)model;
- (void)resetCellWithCamera;

@end
