//
//  CommunityView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/7.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityNavView : UIView
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *selectCommunity;
@property (nonatomic, strong) UIImageView *arrowLocal;
@property (nonatomic, strong) UIImageView *arrowDown;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) void (^blockChangeDistrictClick)(void);
@property (nonatomic, strong) void (^blockSwitchDistrictClick)(void);



@end


@interface CommunitySubCollectionView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *aryModel;/// 标题数组
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) int numPerLine;
- (instancetype)initWithNum:(NSInteger)num;
- (void)resetWithAry:(NSMutableArray *)arydatas;



@end


@interface CommunityInfoCell : UITableViewCell

@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UIImageView *icon;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelNews *)model;

@end


