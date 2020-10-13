//
//  FindJobDetailView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/1.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindJobDetailTopView : UIView
@property (nonatomic, strong) ModelFJJobDetail *modelDetail;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelFJJobDetail *)model;

@end

@interface FindJobDetailLabelView : UIView
@property (nonatomic, strong) ModelFJJobDetail *modelDetail;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelFJJobDetail *)model;

@end

@interface FindJobDetailCompanyView : UIView
@property (nonatomic, strong) ModelFJJobDetail *modelDetail;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelFJJobDetail *)model;

@end

@interface FindJobDetailJobView : UIView
@property (nonatomic, strong) ModelFJJobDetail *modelDetail;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelFJJobDetail *)model;

@end


@interface FindJobDetailConnectView : UIView
@property (nonatomic, strong) ModelFJJobDetail *modelDetail;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelFJJobDetail *)model;

@end
