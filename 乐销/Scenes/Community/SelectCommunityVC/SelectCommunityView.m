//
//  SelectCommunityView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/12.
//Copyright © 2020 ping. All rights reserved.
//

#import "SelectCommunityView.h"

@interface SelectCommunityTopView ()

@end

@implementation SelectCommunityTopView
#pragma mark 懒加载

- (UILabel *)select{
    if (_select == nil) {
        _select = [UILabel new];
        _select.textColor = COLOR_999;
        _select.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _select.numberOfLines = 1;
        _select.lineSpace = 0;
        [_select fitTitle:@"当前定位" variable:0];
        
    }
    return _select;
}
- (UILabel *)near{
    if (!_near) {
        _near = [UILabel new];
        _near.textColor = COLOR_999;
        _near.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _near.numberOfLines = 1;
        _near.lineSpace = 0;
        [_near fitTitle:@"附近小区" variable:0];
    }
    return _near;
}


- (UILabel *)district{
    if (_district == nil) {
        _district = [UILabel new];
        _district.textColor = COLOR_333;
        _district.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _district.numberOfLines = 1;
        _district.lineSpace = 0;
        NSString * communityName = [GlobalData sharedInstance].community.name;
        [_district fitTitle:isStr(communityName)?communityName:@"暂无定位" variable:0];
    }
    return _district;
}
- (UIImageView *)location{
    if (_location == nil) {
        _location = [UIImageView new];
        _location.image = [UIImage imageNamed:@"community_local"];
        _location.widthHeight = XY(W(25),W(25));
    }
    return _location;
}
- (UILabel *)vague{
    if (_vague == nil) {
        _vague = [UILabel new];
        _vague.textColor = [UIColor colorWithHexString:@"#FFA900"];
        _vague.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _vague.numberOfLines = 1;
        _vague.lineSpace = 0;
        [_vague fitTitle:@"手动选择" variable:0];
//        _vague.hidden = true;
    }
    return _vague;
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        self.height = W(50);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.select];
    [self addSubview:self.district];
    [self addSubview:self.location];
    [self addSubview:self.vague];
    [self addSubview:self.near];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    //刷新view
    self.select.leftTop = XY(W(20),W(13));
    
    self.location.leftTop = XY(self.select.left,self.select.bottom+W(15));

    self.district.leftCenterY = XY(self.location.right + W(5),self.location.centerY);
    
    
    self.vague.rightCenterY = XY(SCREEN_WIDTH - W(15),self.location.centerY);
    
        
    [self addControlFrame:CGRectInset(self.vague.frame, -W(50), -W(50)) belowView:self.vague target:self action:@selector(manualClick)];
        
    self.near.leftTop = XY(self.select.left, [self addLineFrame:CGRectMake(0, self.location.bottom + W(15), SCREEN_WIDTH, W(10)) color:COLOR_GRAY]+ W(25));
    self.height = self.near.bottom + W(12.5);
}
#pragma mark click
- (void)manualClick{
    if (self.blockManualClick) {
        self.blockManualClick();
    }
}

@end

@implementation ManualSelectCommunityTopView
#pragma mark 懒加载

- (UILabel *)select{
    if (_select == nil) {
        _select = [UILabel new];
        _select.textColor = COLOR_999;
        _select.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _select.numberOfLines = 1;
        _select.lineSpace = 0;
        [_select fitTitle:@"当前地区" variable:0];
        
    }
    return _select;
}
- (UILabel *)near{
    if (!_near) {
        _near = [UILabel new];
        _near.textColor = COLOR_999;
        _near.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _near.numberOfLines = 1;
        _near.lineSpace = 0;
        [_near fitTitle:@"当前小区" variable:0];
    }
    return _near;
}

- (UILabel *)district{
    if (_district == nil) {
        _district = [UILabel new];
        _district.textColor = COLOR_333;
        _district.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _district.numberOfLines = 1;
        _district.lineSpace = 0;
        [_district fitTitle:@"暂无定位" variable:0];
    }
    return _district;
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        self.height = W(50);
        [self addSubView];
        [self addTarget:self action:@selector(click)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.select];
    [self addSubview:self.district];
    [self addSubview:self.near];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    //刷新view
    self.select.leftTop = XY(W(20),W(13));
    
    self.district.leftTop = XY(W(25),self.select.bottom+W(15));

    self.near.leftTop = XY(self.select.left, [self addLineFrame:CGRectMake(0, self.district.bottom + W(15), SCREEN_WIDTH, W(10)) color:COLOR_GRAY]+ W(25));
    self.height = self.near.bottom + W(12.5);
}

- (void)click{
    if (self.blockClick) {
        self.blockClick();
    }
}
@end

@implementation SelectCommunityCell
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_333;
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _title.numberOfLines = 1;
        _title.lineSpace = 0;
    }
    return _title;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.title];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCommunity *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.title fitTitle:model.name variable:SCREEN_WIDTH - W(50)];
    self.title.leftTop = XY(W(25), W(12.5));
    
    //设置总高度
    self.height = self.title.bottom + W(12.5);
}

@end
