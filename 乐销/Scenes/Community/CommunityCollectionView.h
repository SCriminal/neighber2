//
//  CommunityCollectionView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/7.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPageControlView.h"

@interface CommunityCollectionView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *aryModel;/// 标题数组
@property (nonatomic, strong) void (^blockCommunitySelect)(ModelBtn *);//选中单元格
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) UIImageView *shadow;
@property (nonatomic, strong) CustomPageControlView *pageControl;

- (void)resetWithAry:(NSMutableArray *)arydatas;
- (void)reload;

@end


@interface CommunityCollectionCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UILabel *nameLabel;
@property (nonatomic, strong) ModelModule *model;
@property (nonatomic, strong) UIView *viewAlert;



#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelModule *)model;

@end
