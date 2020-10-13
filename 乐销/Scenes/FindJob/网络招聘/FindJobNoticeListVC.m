//
//  FindJobNoticeListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "FindJobNoticeListVC.h"
//request
#import "RequestApi+FindJob.h"
#import "FindJobNoticeDetailVC.h"
@interface FindJobNoticeListVC ()

@end

@implementation FindJobNoticeListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无内容"];
    }
    return _noResultView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[FindJobNoticeListCell class] forCellReuseIdentifier:@"FindJobNoticeListCell"];
    //request
    [self requestList];
    [self addRefreshHeader];
    [self addRefreshFooter];
}

#pragma mark 添加导航栏
- (void)addNav{
    
    [self.view addSubview:[BaseNavView initNavBackTitle:@"招聘快讯" rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FindJobNoticeListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FindJobNoticeListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [FindJobNoticeListCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelNews *model = self.aryDatas[indexPath.row];

    FindJobNoticeDetailVC * vc = [FindJobNoticeDetailVC new];
    vc.identity = model.iDProperty;
    [GB_Nav pushViewController:vc animated:true];

}
#pragma mark request
- (void)requestList{
   [RequestApi requestFJMainNewsListDelegate:self page:self.pageNum  success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
          self.pageNum ++;
                 NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelNews"];
          
                 if (self.isRemoveAll) {
                     [self.aryDatas removeAllObjects];
                 }
                
                 [self.aryDatas addObjectsFromArray:aryRequest];
              if (self.aryDatas.count >= [response doubleValueForKey:@"total"] ) {
                     [self.tableView.mj_footer endRefreshingWithNoMoreData];
                 }
                 [self.tableView reloadData];
      } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
          
      }];
     
}

@end


@implementation FindJobNoticeListCell
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_333;
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _title.numberOfLines = 3;
        _title.lineSpace = W(5);
    }
    return _title;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_999;
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];

        
    }
    return _time;
}
- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [UIImageView new];
        _icon.widthHeight = XY(W(120),W(92));
        [_icon addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];
    }
    return _icon;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.time];
        [self.contentView addSubview:self.icon];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelNews *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    if (isStr(model.coverUrl)) {
        self.icon.hidden = false;
        [self.icon sd_setImageWithURL:[NSURL URLWithString:model.coverUrl] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
        self.icon.rightTop = XY(SCREEN_WIDTH -  W(15),W(18));
        
        [self.title fitTitle:model.title variable:self.icon.left - W(45)];
        self.title.leftTop = XY(W(15),self.icon.top);
        [self.time fitTitle:[GlobalMethod exchangeTimeWithStamp:model.publishTime andFormatter:TIME_MIN_SHOW] variable:self.icon.left - W(30)];
        self.time.leftBottom = XY(W(15),self.icon.bottom);
        
        
        //设置总高度
        self.height = self.icon.bottom + W(18);
        [self.contentView addLineFrame:CGRectMake(W(15), self.height -1 , SCREEN_WIDTH - W(30), 1)];

    }else{
        self.icon.hidden = true;
        
        [self.title fitTitle:model.title variable:SCREEN_WIDTH - W(30)];
        self.title.leftTop = XY(W(15),W(18));
        [self.time fitTitle:[GlobalMethod exchangeTimeWithStamp:model.publishTime andFormatter:TIME_DAY_SHOW] variable:self.icon.left - W(30)];
        self.time.leftTop = XY(W(15),self.title.bottom+W(13));
        
        //设置总高度
        self.height = self.time.bottom + W(18);
        [self.contentView addLineFrame:CGRectMake(W(15), self.height -1 , SCREEN_WIDTH - W(30), 1)];
    }
}

@end
