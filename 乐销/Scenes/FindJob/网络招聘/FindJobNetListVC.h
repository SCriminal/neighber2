//
//  FindJobNetListVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/11.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseVC.h"
//shadowView
#import "ShadowView.h"

@interface FindJobNetListVC : BaseTableVC

@end

@interface FindJobNetCollectionCell : UICollectionViewCell
@property (strong, nonatomic) ShadowView *viewBG;
@property (strong, nonatomic) UIView *viewFather;
@property (strong, nonatomic) UIImageView *productImage;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *time;
@property (nonatomic, strong) ModelFJNet *model;



#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelFJNet  *)model;

@end
