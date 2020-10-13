//
//  CertificateDealListView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/5/20.
//Copyright © 2020 ping. All rights reserved.
//

#import "CertificateDealListView.h"
#import "CertificateDealDetailVC.h"
@implementation CertificateDealListSectionView
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_999;
        _title.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _title.numberOfLines = 1;
    }
    return _title;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_GRAY;
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
        [self addSubview:self.title];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(NSString *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //设置总高度
    self.height = W(44);

    //刷新view
        [self.title fitTitle:UnPackStr(model) variable:SCREEN_WIDTH- W(30)];
    self.title.leftCenterY = XY(W(15),self.height/2.0);

}

@end


@implementation CertificateDealListCell

#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
    }
    return _labelTitle;
}
- (UIImageView *)arrow{
    if (_arrow == nil) {
        _arrow = [UIImageView new];
        _arrow.image = [UIImage imageNamed:@"setting_RightArrow"];
        _arrow.widthHeight = XY(W(25),W(25));
    }
    return _arrow;
}
- (UIView *)line{
    if (_line == nil) {
        _line = [UIView new];
        _line.backgroundColor = COLOR_LINE;
        _line.widthHeight = XY(SCREEN_WIDTH , 1);
    }
    return _line;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.arrow];
        [self.contentView addSubview:self.line];
//        [self.contentView addTarget:self action:@selector(cellClick)];
    }
    return self;
}

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCertificateDealCategoryItem *)model{
    self.model = model;
    //设置总高度
    self.height = W(45);

    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
        
    [self.labelTitle fitTitle:model.title variable:SCREEN_WIDTH - W(50)];
    self.labelTitle.leftCenterY = XY(W(15),self.height/2.0);
    
    self.arrow.rightCenterY = XY(SCREEN_WIDTH - W(10),self.labelTitle.centerY);
    self.arrow.hidden = true;
    
    self.line.hidden = false;
    self.line.bottom = self.height;
}

#pragma mark click
- (void)cellClick{
    CertificateDealDetailVC * vc = [CertificateDealDetailVC new];
    vc.modelItem = self.model;
    [GB_Nav pushViewController:vc animated:true];
}
@end
