//
//  SelectCommunityDistrictVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/23.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface SelectCommunityDistrictVC : BaseVC<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *aryModel;/// 标题数组
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) ModelCommunityCity *model;
@property (nonatomic, strong) void (^blockSelectCommunity)(ModelCommunity *);

@end


@interface SelectCommunityDistrictCollectionCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIView *BG;

@property (nonatomic, strong) ModelCommunityCity *model;



#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCommunityCity *)model;

@end
