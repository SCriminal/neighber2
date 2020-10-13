//
//  FindJobNewsListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/11.
//Copyright © 2020 ping. All rights reserved.
//

#import "FindJobNewsListVC.h"
//request
#import "RequestApi+FindJob.h"
#import "FindJobNewsDetailVC.h"
@interface FindJobNewsListVC ()

@end

@implementation FindJobNewsListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_message" title:@"暂无新闻"];
    }
    return _noResultView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //table
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.tableView registerClass:[FindJobNewsListCell class] forCellReuseIdentifier:@"FindJobNewsListCell"];
    [self addRefreshHeader];
    [self addRefreshFooter];
    //request
    [self requestList];
}



#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FindJobNewsListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FindJobNewsListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [FindJobNewsListCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelFJNet * model = self.aryDatas[indexPath.row];
    FindJobNewsDetailVC * vc = [FindJobNewsDetailVC new];
    vc.identity = model.iDProperty.doubleValue;
    [GB_Nav pushViewController:vc animated:true];
}
#pragma mark request
- (void)requestList{
    [RequestApi requestFJNewsListDelegate:self page:self.pageNum type:NSNumber.dou(self.type).stringValue success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
               NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelFJNet"];
        
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



@implementation FindJobNewsListCell
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_333;
        _title.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
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
- (void)resetCellWithModel:(ModelFJNet *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
      self.icon.hidden = false;
          [self.icon sd_setImageWithURL:[NSURL URLWithString:model.smallImg] placeholderImage:[UIImage imageNamed:@"newsDefault"]];
          self.icon.rightTop = XY(SCREEN_WIDTH -  W(20),W(18));
          
          [self.title fitTitle:model.title variable:W(187)];
          self.title.leftTop = XY(W(20),self.icon.top);
    [self.time fitTitle:[GlobalMethod exchangeTimeWithStamp:model.addtime.longLongValue andFormatter:TIME_MIN_SHOW] variable:self.icon.left - W(30)];
          self.time.leftBottom = XY(W(20),self.icon.bottom);
          
          //设置总高度
          self.height = self.icon.bottom + W(18);
          [self.contentView addLineFrame:CGRectMake(W(20), self.height -1 , SCREEN_WIDTH - W(40), 1)];
}

@end
