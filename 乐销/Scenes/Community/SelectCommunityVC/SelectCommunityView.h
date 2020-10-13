//
//  SelectCommunityView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/12.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCommunityTopView : UIView
//属性
@property (nonatomic, strong) UILabel *select;
@property (nonatomic, strong) UILabel *district;
@property (nonatomic, strong) UIImageView *location;
@property (nonatomic, strong) UILabel *vague;
@property (nonatomic, strong) UILabel *near;
@property (nonatomic, strong) void (^blockManualClick)(void);


#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end

@interface ManualSelectCommunityTopView : UIView

//属性
@property (nonatomic, strong) UILabel *select;
@property (nonatomic, strong) UILabel *district;
@property (nonatomic, strong) UILabel *near;
@property (nonatomic, strong) void (^blockClick)(void);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end


@interface SelectCommunityCell : UITableViewCell

@property (strong, nonatomic) UILabel *title;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCommunity *)model;

@end
