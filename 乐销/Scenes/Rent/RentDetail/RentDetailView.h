//
//  RentDetailView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/26.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentDetailView : UIView
@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *priceUnit;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *houseMode;
@property (nonatomic, strong) UILabel *floorage;
@property (nonatomic, strong) UILabel *direction;
@property (nonatomic, strong) UILabel *floor;
@property (nonatomic, strong) UILabel *houseModeDetail;
@property (nonatomic, strong) UILabel *floorageDetail;
@property (nonatomic, strong) UILabel *directionDetail;
@property (nonatomic, strong) UILabel *floorDetail;
@property (nonatomic, strong) UILabel *remark;
@property (nonatomic, strong) UILabel *remarkDetail;


#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
