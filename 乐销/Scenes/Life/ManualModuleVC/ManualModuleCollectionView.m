//
//  ManualModuleCollectionView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/7.
//Copyright © 2020 ping. All rights reserved.
//

#import "ManualModuleCollectionView.h"

@interface ManualModuleCollectionView ()

@end

@implementation ManualModuleCollectionView
@synthesize aryModel = _aryModel;

#pragma mark 懒加载
-(UILongPressGestureRecognizer *)longPress{
    if (!_longPress) {
        _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lonePressMoving:)];
    }
    return _longPress;
}

- (NSMutableArray *)aryModel{
    if (!_aryModel) {
//        _aryModel = [GlobalMethod readAry:[NSString stringWithFormat:@"%@%@",LOCAL_MODULE,[self fetchParentID]] modelName:@"ModelCropListItem"];
        _aryModel = [NSMutableArray array];
    }
    return _aryModel;
}
- (CGFloat)cellHeight{
    if (_cellHeight == 0) {
        _cellHeight = [ManualModuleCollectionCell fetchHeight:[ModelModule new]];
    }
    return _cellHeight;
}

#pragma mark-----  设置collectionview
- (UICollectionView *)myCollectionView {
    if (!_myCollectionView) {
        // 1.流水布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 1;
        layout.sectionInset = UIEdgeInsetsMake(1, W(4), 0, W(4));
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-W(8)) / self.numPerLine - 1 , self.cellHeight);
        
        //设定滚动方向，有UICollectionViewScrollDirectionVertical和UICollectionViewScrollDirectionHorizontal两个值。
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 6.创建UICollectionView
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFLOAT_MIN) collectionViewLayout:layout];
        if (@available(iOS 11.0, *)) {
            _myCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        // 7.设置collectionView的背景色
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        // 8.设置代理
        _myCollectionView.collectionViewLayout = layout;
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.scrollEnabled = YES;
        _myCollectionView.showsVerticalScrollIndicator = false;
        // 9.注册cell(告诉collectionView将来创建怎样的cell)
        [_myCollectionView registerClass:[ManualModuleCollectionCell class] forCellWithReuseIdentifier:@"ManualModuleCollectionCell"];
        [_myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
        [_myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        _myCollectionView.clipsToBounds = false;

        if (self.isEditable) {
                    [_myCollectionView addGestureRecognizer:self.longPress];
        }
    }
    return _myCollectionView;
}


#pragma mark----- 长按手势
- (void)lonePressMoving:(UILongPressGestureRecognizer *)longPress
{
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: {
            {
                NSIndexPath *selectIndexPath = [self.myCollectionView indexPathForItemAtPoint:[longPress locationInView:self.myCollectionView]];
                [self.myCollectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self.myCollectionView updateInteractiveMovementTargetPosition:[longPress locationInView:longPress.view]];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            [self.myCollectionView endInteractiveMovement];
            break;
        }
        default: [self.myCollectionView cancelInteractiveMovement];
            break;
    }
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath
{
    //取出源item数据
    id objc = [self.aryModel objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [self.aryModel removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [self.aryModel insertObject:objc atIndex:destinationIndexPath.item];
    //重新排序
    [self resortAry];
    [self performSelector:@selector(reload) withObject:nil afterDelay:0.5];
}
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    ModelModule * model =  self.aryModel[indexPath.row];
    if (model.iDProperty == 0) {
        return  false;
    }
    return  true;
}

//resetAry
- (void)resortAry{
    NSMutableArray * aryMu = [NSMutableArray new];
    for (ModelModule * model in self.aryModel) {
        if (model.iDProperty != 0) {
            [aryMu addObject:model];
        }
    }
    self.aryModel = aryMu;
    if (self.blockResortModule) {
        self.blockResortModule();
    }
}
//刷新
- (void)reload{
    [self.myCollectionView reloadData];
}

#pragma mark - UICollectionView数据源方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.aryModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.获得cell
    ManualModuleCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ManualModuleCollectionCell" forIndexPath:indexPath];
    ModelModule * model = self.aryModel[indexPath.row];
    [cell resetCellWithModel:model];
    cell.iconOperate.image =  [UIImage imageNamed:self.isEditable?@"manual_model_del":@"manual_model_add"];
    if (!self.isEditable && model.isSelected) {
        cell.iconOperate.image =  [UIImage imageNamed:@"manual_model_del"];
    }
    return cell;
}

#pragma mark - 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.blockModelClick) {
        self.blockModelClick(self.aryModel[indexPath.row], self.isEditable);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, CGFLOAT_MIN);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, CGFLOAT_MIN);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        return view;
    }
    UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot" forIndexPath:indexPath];
    [view  addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1) color:COLOR_BACKGROUND];
    return view;
}

- (instancetype)initWithNum:(NSInteger)num isEditable:(BOOL)isEditable{
    self = [super init];
       if (self) {
           self.numPerLine = num;
           self.isEditable = isEditable;
           self.clipsToBounds = false;
           [self config];
       }
       return self;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.numPerLine = 4;
        [self config];
    }
    return self;
}
- (void)config{
    [self addSubview:self.myCollectionView];
    self.backgroundColor = [UIColor whiteColor];

}
#pragma mark reset view
- (void)resetWithAry:(NSMutableArray *)ary{
    self.aryModel = ary;
    int numLine = (int)(ary.count/self.numPerLine+(ary.count%self.numPerLine==0?0:1));
    self.width = SCREEN_WIDTH;
    self.height = (self.cellHeight+1)*numLine;
    self.myCollectionView.height = self.height;
    self.myCollectionView.width = SCREEN_WIDTH ;
    [self.myCollectionView reloadData];
}
@end



@implementation ManualModuleCollectionCell
#pragma mark 懒加载

- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.widthHeight = XY(W(50),W(50));
    }
    return _iconImg;
}
- (UIImageView *)iconOperate{
    if (_iconOperate == nil) {
        _iconOperate = [UIImageView new];
        _iconOperate.widthHeight = XY(W(10),W(10));
    }
    return _iconOperate;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.fontNum = F(12);
        _nameLabel.textColor = [UIColor colorWithHexString:@"717273"];
    }
    return _nameLabel;
}
#pragma mark 初始化

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.iconOperate];

    }
    return self;
}


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelModule *)model{
    self.model = model;
    //刷新view
    self.iconImg.centerXTop = XY(self.contentView.width / 2,W(0));
    self.iconOperate.rightTop = self.iconImg.rightTop;
    //设置图片
    UIImage * image = [UIImage imageNamed:model.iconUrl];
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:image?image:[UIImage imageNamed:@"default_module"]];
    
    [self.nameLabel  fitTitle:model.moduleName  variable:0];
    self.nameLabel.centerXTop = XY(self.iconImg.centerX,W(3) + self.iconImg.bottom);
    
    self.height = self.nameLabel.bottom + W(25);
    
    
}


@end
