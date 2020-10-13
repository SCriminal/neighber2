//
//  ManualManualModuleCollectionView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/10.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ManualModuleCollectionView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *aryModel;/// 标题数组
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) int numPerLine;
@property (nonatomic, assign) BOOL isMyself;
@property (nonatomic, assign) BOOL isEditable;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (nonatomic, strong) void (^blockResortModule)(void);//调整位置

@property (nonatomic, strong) void (^blockModelClick)(ModelModule *, BOOL);
- (instancetype)initWithNum:(NSInteger)num isEditable:(BOOL)isEditable;
- (void)resetWithAry:(NSMutableArray *)arydatas;

@end


@interface ManualModuleCollectionCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UIImageView *iconOperate;
@property (strong, nonatomic) UILabel *nameLabel;
@property (nonatomic, strong) ModelModule *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelModule *)model;

@end
