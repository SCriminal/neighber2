//
//  CertificateDealListView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/5/20.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CertificateDealListSectionView : UIView
@property (nonatomic, strong) UILabel *title;

#pragma mark 刷新view
- (void)resetViewWithModel:(NSString *)model;

@end

@interface CertificateDealListCell : UITableViewCell

@property (strong, nonatomic) UILabel *labelTitle;

@property (strong, nonatomic) UIImageView *arrow;
@property (strong, nonatomic) UIView *line;
@property (nonatomic, strong) ModelCertificateDealCategoryItem *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCertificateDealCategoryItem *)model;

@end
