//
//  EHomeMainVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/27.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface EHomeMainVC : BaseTableVC

@end


@interface EHomeMainTopView : UIView
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) UIImageView *BG;
@property (strong, nonatomic) UIImageView *whiteBG;
@property (strong, nonatomic) UIImageView *head;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *subtitle;
- (void)resetViewWithModel:(ModelArchiveList *)modelArchive;
@end

@interface EHomeCompanyView : UIView
//属性
@property (strong, nonatomic) UILabel *companyName;
@property (nonatomic, strong) ModelEHomeWuYeInfo *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelEHomeWuYeInfo *)model;
@end

@interface EHomeOrderView : UIView
@property (nonatomic, strong) void (^blockClick)(void);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
@end
