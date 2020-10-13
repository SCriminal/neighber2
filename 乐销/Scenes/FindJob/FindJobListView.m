//
//  FindJobListView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/31.
//Copyright © 2020 ping. All rights reserved.
//

#import "FindJobListView.h"
#import "ArchivePickView.h"
#import "RequestApi+FindJob.h"


@implementation FindJobListCell
#pragma mark 懒加载
- (UIImageView *)logo{
    if (_logo == nil) {
        _logo = [UIImageView new];
        _logo.widthHeight = XY(W(40),W(40));
        [_logo addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:1 lineColor:COLOR_LINE];
    }
    return _logo;
}
- (UILabel *)jobName{
    if (_jobName == nil) {
        _jobName = [UILabel new];
        _jobName.textColor = COLOR_333;
        _jobName.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _jobName;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = COLOR_ORANGE;
        _price.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _price;
}
- (UILabel *)companyName{
    if (_companyName == nil) {
        _companyName = [UILabel new];
        _companyName.textColor = COLOR_999;
        _companyName.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _companyName;
}
- (UILabel *)detail{
    if (_detail == nil) {
        _detail = [UILabel new];
        _detail.textColor = COLOR_333;
        _detail.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _detail.numberOfLines = 3;
        _detail.lineSpace = W(7);
    }
    return _detail;
}
- (UIView *)label{
    if (_label == nil) {
        _label = [UIView new];
        _label.backgroundColor = [UIColor clearColor];
        _label.width = SCREEN_WIDTH;
        _label.height = W(21);

    }
    return _label;
}
- (UIView *)btn{
    if (_btn == nil) {
        _btn = [UIView new];
        _btn.backgroundColor =  [UIColor whiteColor];
        _btn.widthHeight = XY(SCREEN_WIDTH, W(41));
    }
    return _btn;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        {
            [self.contentView addSubview:^(){
                UIView * view = [UIView new];
                view.backgroundColor = COLOR_GRAY;
                view.widthHeight = XY(SCREEN_WIDTH, W(10));
                return view;
            }()];
        }
        [self.contentView addSubview:self.logo];
        [self.contentView addSubview:self.jobName];
        [self.contentView addSubview:self.price];
        [self.contentView addSubview:self.companyName];
        [self.contentView addSubview:self.detail];
        [self.contentView addSubview:self.label];
//        [self.contentView addSubview:self.btn];
        {
            [self.btn addLineFrame:CGRectMake(W(15), 0, SCREEN_WIDTH - W(30), 1)];
            
            NSArray * aryImage = @[@"findJob_share",@"findJob_recollect",@"findJob_unfavorite"];
            NSArray * aryImageHigh = @[@"findJob_share",@"findJob_collect",@"findJob_favorite"];
            
            NSArray * aryTitle = @[@"投简历",@"收藏",@"点赞"];
            NSArray * aryLeft= @[@77.5,@202.75,@327.75];
            for (int i = 0; i<aryImage.count; i++) {
                UILabel * l = [UILabel new];
                l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
                l.textColor = COLOR_333;
                l.backgroundColor = [UIColor clearColor];
                l.numberOfLines = 0;
                l.lineSpace = W(0);
                [l fitTitle:aryTitle[i] variable:SCREEN_WIDTH - W(30)];
                l.centerXCenterY = XY([aryLeft[i] doubleValue], self.btn.height/2.0);
                [self.btn addSubview:l];
                
                UIImageView * iv = [UIImageView new];
                iv.backgroundColor = [UIColor clearColor];
                iv.contentMode = UIViewContentModeScaleAspectFill;
                iv.clipsToBounds = true;
                iv.image = [UIImage imageNamed:aryImage[i]];
                iv.highlightedImage = [UIImage imageNamed:aryImageHigh[i]];
                iv.widthHeight = XY(W(20),W(20));
                iv.rightCenterY = XY(l.left - W(10),l.centerY);
                iv.tag = i + 100;
                [self.btn addSubview:iv];
                
                UIView * con = [self.btn addControlFrame:CGRectMake([aryLeft[i] doubleValue] - W(125)/2.0, 0, W(125), self.btn.height) target:self action:@selector(conClick:)];
                con.tag =i;
                if (i == 0) {
                    [self.btn addLineFrame:CGRectMake(W(125), W(14), 1, W(15))];
                }
                if (i == 1) {
                    [self.btn addLineFrame:CGRectMake(W(250), W(14), 1, W(15))];
                }
            }
        }
    }
    return self;
}
- (void)conClick:(UIControl *)con{
    switch ((int)con.tag) {
        case 0:
        {
            NSLog(@"投简历");
        }
            break;
        case 1:
        {
            UIImageView * iv = [self.btn viewWithTag:con.tag + 100];
            iv.highlighted = !iv.highlighted;
        }
            break;
        case 2:
        {
            UIImageView * iv = [self.btn viewWithTag:con.tag + 100];
            iv.highlighted = !iv.highlighted;
        }
            break;
        default:
            break;
    }
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelFJJobList *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    [self.logo sd_setImageWithURL:[NSURL URLWithString:UnPackStr(model.logo)] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_COMPANY_DEFAULT]];
    self.logo.leftTop = XY(W(15),W(30));
    [self.jobName fitTitle:UnPackStr(model.jobsName) variable:W(200)];
    self.jobName.leftTop = XY(self.logo.right + W(8),self.logo.top+W(1));
    [self.price fitTitle:UnPackStr(model.wageCn) variable:0];
    self.price.rightTop = XY(SCREEN_WIDTH -  W(15),self.logo.top);
    [self.companyName fitTitle:[NSString stringWithFormat:@"%@ %@",UnPackStr(model.companyname),UnPackStr(model.districtCn)] variable:W(300)];
    self.companyName.leftBottom = XY(self.logo.right + W(8),self.logo.bottom);
    
    CGFloat top = self.logo.bottom;
    
    self.label.hidden = true;
    if (model.tagCn.count > 0 && [model.tagCn componentsJoinedByString:@""].length > 1) {
        self.label.hidden = false;
        [self.label removeAllSubViews];
        self.label.top = top + W(13);
        CGFloat left = W(15);
        for (NSString * lStr in model.tagCn) {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor colorWithHexString:@"#F7F8F9"];

            l.textAlignment = NSTextAlignmentCenter;
    
            
            l.width = MIN([UILabel fetchWidthFontNum:F(11) text:lStr]+ W(14), SCREEN_WIDTH - W(30));
            l.height = W(21);
                    [l addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:3 lineWidth:0 lineColor:[UIColor clearColor]];
            l.text = lStr;
            if (l.width + left > SCREEN_WIDTH) {
                break;
            }else{
                l.leftTop = XY(left, 0);
                left = l.right + W(10);
                [self.label addSubview:l];
            }
        }
        top = self.label.bottom;
    }
    
    [self.detail fitTitle:UnPackStr(model.contents) variable:SCREEN_WIDTH - W(30)];
    self.detail.leftTop = XY(W(15),top+W(13));
    
//    self.btn.top = self.detail.bottom + W(20);
    
    //设置总高度
    self.height = self.detail.bottom + W(20);
}

@end


@implementation FindJobFilterView
#pragma mark 懒加载
- (UILabel *)filter0{
    if (_filter0 == nil) {
        _filter0 = [UILabel new];
        _filter0.textColor = COLOR_333;
        _filter0.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_filter0 fitTitle:@"地区" variable:0];
    }
    return _filter0;
}
- (UILabel *)filter1{
    if (_filter1 == nil) {
        _filter1 = [UILabel new];
        _filter1.textColor = COLOR_333;
        _filter1.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_filter1 fitTitle:@"薪资" variable:0];

    }
    return _filter1;
}
- (UILabel *)filter2{
    if (_filter2 == nil) {
        _filter2 = [UILabel new];
        _filter2.textColor = COLOR_333;
        _filter2.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_filter2 fitTitle:@"经验" variable:0];

    }
    return _filter2;
}

- (UIImageView *)icon0{
    if (_icon0 == nil) {
        _icon0 = [UIImageView new];
        _icon0.image = [UIImage imageNamed:@"arrow_down_default"];
        _icon0.highlightedImage = [UIImage imageNamed:@"arrow_down_selected"];
        _icon0.widthHeight = XY(W(15),W(15));
    }
    return _icon0;
}
- (UIImageView *)icon1{
    if (_icon1 == nil) {
        _icon1 = [UIImageView new];
        _icon1.image = [UIImage imageNamed:@"arrow_down_default"];
        _icon1.highlightedImage = [UIImage imageNamed:@"arrow_down_selected"];
        _icon1.widthHeight = XY(W(15),W(15));
    }
    return _icon1;
}
- (UIImageView *)icon2{
    if (_icon2 == nil) {
        _icon2 = [UIImageView new];
        _icon2.image = [UIImage imageNamed:@"arrow_down_default"];
        _icon2.highlightedImage = [UIImage imageNamed:@"arrow_down_selected"];
        _icon2.widthHeight = XY(W(15),W(15));
    }
    return _icon2;
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
        [self addSubview:self.filter0];
    [self addSubview:self.filter1];
    [self addSubview:self.filter2];
        [self addSubview:self.icon0];
    [self addSubview:self.icon1];
    [self addSubview:self.icon2];
    self.filter0.leftTop = XY(W(15),W(10));
    self.icon0.leftCenterY = XY(self.filter0.right + W(2), self.filter0.centerY);
      
    self.filter1.leftCenterY = XY(self.icon0.right + W(30),self.filter0.centerY);
    self.icon1.leftCenterY = XY(self.filter1.right + W(2), self.filter0.centerY);
    
    self.filter2.leftCenterY = XY(self.icon1.right + W(30),self.filter0.centerY);
    self.icon2.leftCenterY = XY(self.filter2.right + W(2), self.filter0.centerY);


    UIImageView * iv = [UIImageView new];
    iv.backgroundColor = [UIColor clearColor];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.clipsToBounds = true;
    iv.image = [UIImage imageNamed:@"houseKeeping_filter"];
    iv.widthHeight = XY(W(15),W(15));
    iv.rightCenterY = XY(SCREEN_WIDTH - W(15),self.filter0.centerY);
    [self addSubview:iv];
    
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    l.textColor = COLOR_333;
    l.backgroundColor = [UIColor clearColor];
    l.numberOfLines = 0;
    l.lineSpace = W(0);
    [l fitTitle:@"筛选" variable:SCREEN_WIDTH - W(30)];
    l.rightCenterY = XY(iv.left - W(2), iv.centerY);
    [self addSubview:l];
    


    //设置总高度
    self.height = self.filter0.bottom + W(15);
    [self addControlFrame:CGRectMake(0, 0, self.icon0.right + W(15), self.height) target:self action:@selector(leftClick)];
    [self addControlFrame:CGRectMake(self.filter1.left - W(15), 0, self.icon0.right + W(15), self.height) target:self action:@selector(midClick)];
    
    [self addControlFrame:CGRectMake(self.filter2.left - W(15), 0, self.icon1.right + W(15), self.height) target:self action:@selector(rightClick)];

    [self addControlFrame:CGRectMake(SCREEN_WIDTH - W(80), 0,  W(80), self.height) target:self action:@selector(filterClick)];

}

#pragma mark click
- (void)leftClick{
    if (self.blockIndexClick) {
           self.blockIndexClick(0);
       }
   
}
- (void)midClick{
    if (self.blockIndexClick) {
        self.blockIndexClick(1);
    }
}
- (void)rightClick{
    if (self.blockIndexClick) {
        self.blockIndexClick(2);
    }
}
- (void)filterClick{
    if (self.blockFilterClick) {
        self.blockFilterClick();
    }
}
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view

    
}

@end


@interface FindJobFilterAllView ()
@property (nonatomic, assign) CGRect borderFrame;
@end

@implementation FindJobFilterAllView

#pragma mark 懒加载
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
    }
    return _viewBG;
}
- (UILabel *)select0{
    if (_select0 == nil) {
        _select0 = [UILabel new];
        _select0.font = [UIFont systemFontOfSize:F(15)];
        _select0.textColor = COLOR_999;
        _select0.backgroundColor = [UIColor clearColor];
        [_select0 fitTitle:@"请选择工作性质" variable:0];
    }
    return _select0;
}
- (UILabel *)select1{
    if (_select1 == nil) {
        _select1 = [UILabel new];
        _select1.font = [UIFont systemFontOfSize:F(15)];
        _select1.textColor = COLOR_999;
        _select1.backgroundColor = [UIColor clearColor];
        [_select1 fitTitle:@"请选择学历要求" variable:0];
    }
    return _select1;
}
- (UILabel *)select2{
    if (_select2 == nil) {
        _select2 = [UILabel new];
        _select2.font = [UIFont systemFontOfSize:F(15)];
        _select2.textColor = COLOR_999;
        _select2.backgroundColor = [UIColor clearColor];
        [_select2 fitTitle:@"请选择福利待遇" variable:0];
    }
    return _select2;
}
- (UILabel *)select3{
    if (_select3 == nil) {
        _select3 = [UILabel new];
        _select3.font = [UIFont systemFontOfSize:F(15)];
        _select3.textColor = COLOR_999;
        _select3.backgroundColor = [UIColor clearColor];
        [_select3 fitTitle:@"请选择更新时间" variable:0];
    }
    return _select3;
}
- (UIButton *)btnSearch{
    if (_btnSearch == nil) {
        _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSearch.backgroundColor = COLOR_ORANGE;
        _btnSearch.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnSearch setTitle:@"筛选" forState:(UIControlStateNormal)];
        [_btnSearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSearch addTarget:self action:@selector(btnSearchClick) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:_btnSearch color:[UIColor clearColor] numRound:5 width:0];
    }
    return _btnSearch;
}
- (UIButton *)btnReset{
    if (_btnReset == nil) {
        _btnReset = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnReset.backgroundColor = COLOR_ORANGE;
        _btnReset.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnReset setTitle:@"重置" forState:(UIControlStateNormal)];
        [_btnReset setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnReset addTarget:self action:@selector(btnResetClick) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:_btnReset color:[UIColor clearColor] numRound:5 width:0];
    }
    return _btnReset;
}
- (UIView *)viewBlackAlpha{
    if (!_viewBlackAlpha) {
        _viewBlackAlpha = [UIView new];
        _viewBlackAlpha.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
        _viewBlackAlpha.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _viewBlackAlpha;
}
- (ModelBaseData *)modelEducation{
    if (!_modelEducation) {
        _modelEducation =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.placeHolderString = @"请选择学历要求";

            WEAKSELF
            model.blocClick = ^(ModelBaseData *item) {
                if (item.aryDatas.count) {
                    NSMutableArray * aryStr = [NSMutableArray new];
                    for (ModelFJData * modelData in item.aryDatas) {
                        [aryStr addObject:UnPackStr(modelData.categoryname)];
                    }
                    ArchivePickView * pickView = [ArchivePickView new];
                    [pickView resetViewWithAry:aryStr];
                    [[UIApplication sharedApplication].keyWindow addSubview:pickView];
                    pickView.blockSelect = ^(NSInteger index) {
                        if (index<=item.aryDatas.count-1) {
                            ModelFJData * modelSelect = item.aryDatas[index];
                            weakSelf.modelEducation.identifier = modelSelect.iDProperty;
                            weakSelf.modelEducation.subString = modelSelect.categoryname;
                            [weakSelf configData];
                        }
                    };
                }else{
                    [RequestApi requestFJEducationDataListDelegate:(BaseVC *)GB_Nav.lastVC success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        item.aryDatas = [ModelFJData transferDic:[response objectForKey:@"list"]];
                        [weakSelf.modelEducation click];
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                }
            };
            return model;
        }();
    }
    return _modelEducation;
}
- (ModelBaseData *)modelWelfare{
    if (!_modelWelfare) {
        _modelWelfare =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.placeHolderString = @"请选择福利待遇";

            WEAKSELF
            model.blocClick = ^(ModelBaseData *item) {
                if (item.aryDatas.count) {
                    NSMutableArray * aryStr = [NSMutableArray new];
                    for (ModelFJData * modelData in item.aryDatas) {
                        [aryStr addObject:UnPackStr(modelData.categoryname)];
                    }
                    ArchivePickView * pickView = [ArchivePickView new];
                    [pickView resetViewWithAry:aryStr];
                    [[UIApplication sharedApplication].keyWindow addSubview:pickView];
                    pickView.blockSelect = ^(NSInteger index) {
                        if (index<=item.aryDatas.count-1) {
                            ModelFJData * modelSelect = item.aryDatas[index];
                            weakSelf.modelWelfare.identifier = modelSelect.iDProperty;
                            weakSelf.modelWelfare.subString = modelSelect.categoryname;
                            [weakSelf configData];
                        }
                    };
                }else{
                    [RequestApi requestFJWellfareDataListDelegate:(BaseVC *)GB_Nav.lastVC success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        item.aryDatas = [ModelFJData transferDic:[response objectForKey:@"list"]];
                        [weakSelf.modelWelfare click];
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                }
            };
            return model;
        }();
    }
    return _modelWelfare;
}
- (ModelBaseData *)modelWorkProperty{
    if (!_modelWorkProperty) {
        _modelWorkProperty =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.string = @"工作性质";
            model.placeHolderString = @"请选择工作性质";
            WEAKSELF
                    model.blocClick = ^(ModelBaseData *item) {
                        if (item.aryDatas.count) {
                            NSMutableArray * aryStr = [NSMutableArray new];
                            for (ModelFJData * modelData in item.aryDatas) {
                                [aryStr addObject:UnPackStr(modelData.categoryname)];
                            }
                            ArchivePickView * pickView = [ArchivePickView new];
                            [pickView resetViewWithAry:aryStr];
                            [[UIApplication sharedApplication].keyWindow addSubview:pickView];
                            pickView.blockSelect = ^(NSInteger index) {
                                if (index<=item.aryDatas.count-1) {
                                    ModelFJData * modelSelect = item.aryDatas[index];
                                    weakSelf.modelWorkProperty.identifier = modelSelect.iDProperty;
                                    weakSelf.modelWorkProperty.subString = modelSelect.categoryname;
                                    [weakSelf configData];
                                }
                            };
                        }else{
                            [RequestApi requestFJJobNatureDataListDelegate:(BaseVC *)GB_Nav.lastVC success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                                item.aryDatas = [ModelFJData transferDic:[response objectForKey:@"list"]];
                                [weakSelf.modelWorkProperty click];
                            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                                
                            }];
                        }
                    };
            
            
            return model;
        }();
    }
    return _modelWorkProperty;
}
- (ModelBaseData *)modelRefreshDate{
    if (!_modelRefreshDate) {
        _modelRefreshDate =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.placeHolderString = @"请选择更新时间";
            WEAKSELF
            model.blocClick = ^(ModelBaseData *item) {
                if (item.aryDatas.count) {
                    NSMutableArray * aryStr = [NSMutableArray new];
                    for (ModelFJData * modelData in item.aryDatas) {
                        [aryStr addObject:UnPackStr(modelData.categoryname)];
                    }
                    ArchivePickView * pickView = [ArchivePickView new];
                    [pickView resetViewWithAry:aryStr];
                    [[UIApplication sharedApplication].keyWindow addSubview:pickView];
                    pickView.blockSelect = ^(NSInteger index) {
                        if (index<=item.aryDatas.count-1) {
                            ModelFJData * modelSelect = item.aryDatas[index];
                            weakSelf.modelRefreshDate.identifier = modelSelect.iDProperty;
                            weakSelf.modelRefreshDate.subString = modelSelect.categoryname;
                            [weakSelf configData];
                        }
                    };
                }else{
                    [RequestApi requestFJRefreshDataListDelegate:(BaseVC *)GB_Nav.lastVC success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        item.aryDatas = [ModelFJData transferDic:[response objectForKey:@"list"]];
                        [weakSelf.modelRefreshDate click];
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                }
            };
            return model;
        }();
    }
    return _modelRefreshDate;
}
- (void)configData{
    [self.select0 fitTitle:isStr(self.modelWorkProperty.subString)?self.modelWorkProperty.subString:self.modelWorkProperty.placeHolderString variable:W(180)];
    [self.select1 fitTitle:isStr(self.modelEducation.subString)?self.modelEducation.subString:self.modelEducation.placeHolderString variable:W(180)];
    [self.select2 fitTitle:isStr(self.modelWelfare.subString)?self.modelWelfare.subString:self.modelWelfare.placeHolderString variable:W(180)];
    [self.select3 fitTitle:isStr(self.modelRefreshDate.subString)?self.modelRefreshDate.subString:self.modelRefreshDate.placeHolderString variable:W(180)];

}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addSubView];
        [self addTarget:self action:@selector(closeClick)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBlackAlpha];
    [self addSubview:self.viewBG];
    [self.viewBG addSubview:self.btnSearch];
    [self.viewBG addSubview:self.btnReset];
    [self.viewBG addSubview:self.select0];
    [self.viewBG addSubview:self.select1];
    [self.viewBG addSubview:self.select2];
    [self.viewBG addSubview:self.select3];

}

#pragma mark 刷新view
- (void)configView{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.viewBG.width = SCREEN_WIDTH;
    self.viewBG.centerXTop = XY(SCREEN_WIDTH/2.0,NAVIGATIONBAR_HEIGHT);
    NSArray * ary = @[@"工作性质",@"学历要求",@"福利待遇",@"更新时间"];
    CGFloat top = W(20);
    for (int i = 0; i<ary.count; i++) {
        {
               UIView * viewBorder = [self generateBorder:CGRectMake(W(96), top, W(259), W(45))];
            top = viewBorder.bottom + W(20);
               [self.viewBG addSubview:viewBorder];
            viewBorder.tag = i;
            [viewBorder addTarget:self action:@selector(selectClick:)];
            UIView * viewL = [self valueForKey:[NSString stringWithFormat:@"select%d",i]];
               viewL.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);

               UILabel * l = [UILabel new];
               l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
               l.textColor = COLOR_333;
               l.backgroundColor = [UIColor clearColor];
               [l fitTitle:ary[i] variable:0];
               l.leftCenterY = XY(W(20), viewBorder.centerY);
               [self.viewBG addSubview:l];

               UIImageView *ivDown = [UIImageView new];
               ivDown.image = [UIImage imageNamed:@"accountDown"];
               ivDown.widthHeight = XY(W(25),W(25));
               [self.viewBG addSubview:ivDown];
               ivDown.rightCenterY = XY(viewBorder.right - W(10), viewBorder.centerY);

           }
    }
    self.btnSearch.widthHeight = XY(W(160),W(45));
    self.btnReset.widthHeight = XY(W(160),W(45));
    self.btnSearch.leftTop = XY(self.viewBG.width/2.0 + W(7.5),top);
    self.btnReset.rightTop = XY(self.viewBG.width/2.0 - W(7.5),top);
    
    self.viewBG.widthHeight = XY(SCREEN_WIDTH,self.btnSearch.bottom + W(20));

}
- (UIView *)generateBorder:(CGRect)frame{
    UIView * viewBorder = [UIView new];
    viewBorder.backgroundColor = [UIColor clearColor];
    [GlobalMethod setRoundView:viewBorder color:COLOR_LINE numRound:5 width:1];
    viewBorder.frame = frame;
    return viewBorder;
}

- (void)selectClick:(UITapGestureRecognizer *)tap{
    UIView * view = tap.view;
    switch (view.tag) {
        case 0:
            {
                [self.modelWorkProperty click];

            }
            break;
            case 1:
                      {
                          [self.modelEducation click];

                      }
                      break;
            case 2:
                      {
                          [self.modelWelfare click];

                      }
                      break;
            case 3:
                      {
                          [self.modelRefreshDate click];
                      }
                      break;
        default:
            break;
    }
}

#pragma mark 销毁
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)closeClick{
    if ([self fetchFirstResponder]) {
        [GlobalMethod endEditing];
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)show{
    self.alpha = 1;
    [GB_Nav.lastVC.view addSubview:self];
}


- (void)btnSearchClick{
    if (self.blockSelected) {
        self.blockSelected(self.modelWorkProperty.identifier.intValue, self.modelEducation.identifier.intValue, self.modelWelfare.identifier.intValue, self.modelRefreshDate.identifier.intValue);
    }
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}

- (void)btnResetClick{
    self.modelWorkProperty.identifier = nil;
    self.modelEducation.identifier = nil;
    self.modelWelfare.identifier = nil;
    self.modelRefreshDate.identifier = nil;
    [self configData];
    [self btnSearchClick];
    
}
@end
