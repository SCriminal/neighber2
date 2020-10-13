//
//  ProductDetailView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/11.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailTitleView : UIView
@property (strong, nonatomic) UILabel *scoreNum;
@property (strong, nonatomic) UILabel *score;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *remain;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UIView *grayBG;
@property (strong, nonatomic) UILabel *detail;
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelIntegralProduct *)model;

@end
