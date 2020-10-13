//
//  ModuleCollectionView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/7.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModuleCollectionView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *aryModel;/// 标题数组
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) int numPerLine;
@property (nonatomic, assign) BOOL isMyself;
- (instancetype)initWithNum:(NSInteger)num;
- (void)resetWithAry:(NSMutableArray *)arydatas;
- (void)reload;

@end


@interface ModuleCollectionCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UILabel *nameLabel;
@property (nonatomic, strong) ModelModule *model;



#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelModule *)model;

@end
