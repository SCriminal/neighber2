//
//  HailuoAllCommentListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/18.
//Copyright © 2020 ping. All rights reserved.
//

#import "HailuoAllCommentListVC.h"
#import "HailuoAppointmentView.h"
//request
#import "RequestApi+Hailuo.h"
#import "SliderView.h"
#import "HailuoAuntResumeView.h"

@interface HailuoAllCommentListVC ()<SliderViewDelegate>
@property (strong, nonatomic) SliderView *sliderView;
@property (nonatomic, assign) int index;

@end

@implementation HailuoAllCommentListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无评价"];
    }
    return _noResultView;
}
- (SliderView *)sliderView{
    if (_sliderView == nil) {
        _sliderView = ^(){
            SliderView * sliderView = [SliderView new];
            sliderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, W(50));
            sliderView.isHasSlider = true;
            sliderView.viewSlidColor = COLOR_ORANGE;
            sliderView.viewSlidWidth = W(30);
            sliderView.isScroll = false;
            sliderView.isLineVerticalHide = true;
            sliderView.delegate = self;
            sliderView.line.hidden = true;
            [sliderView resetWithAry:@[^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"好评";
                return model;
            }(),^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"中评";
                return model;
            }(),^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"差评";
                return model;
            }()]];
            return sliderView;
        }();
        _sliderView.top = NAVIGATIONBAR_HEIGHT;
    }
    return _sliderView;
}
- (void)protocolSliderViewBtnSelect:(NSUInteger)tag btn:(CustomSliderControl *)control{
    self.index = (int)tag;
    [self refreshHeaderAll];
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.sliderView];
    self.tableView.top = self.sliderView.bottom;
    self.tableView.height = SCREEN_HEIGHT - self.sliderView.bottom;
    //table
[self.tableView registerClass:[HailuoAppointmentCell class] forCellReuseIdentifier:@"HailuoAppointmentCell"];
    self.tableView.contentInset = UIEdgeInsetsMake(W(20), 0, 0, 0);
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"全部评价" rightView:nil]];
}
#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HailuoAppointmentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HailuoAppointmentCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HailuoAppointmentCell fetchHeight:self.aryDatas[indexPath.row]];
}


#pragma mark request
- (void)requestList{
    if (self.companyID) {
        [RequestApi requestHaiLuoCompanyComment:NSNumber.dou(self.companyID).stringValue status:self.index+1 page:self.pageNum delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [self requestSuccess:response];

        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }else{
        [RequestApi requestHaiLuoAuntComment:NSNumber.dou(self.auntID).stringValue status:self.index+1 page:self.pageNum delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [self requestSuccess:response];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }
}
- (void)requestSuccess:(NSDictionary *)response{
    self.pageNum ++;
    NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelHailuoComment"];
    if (self.isRemoveAll) {
        [self.aryDatas removeAllObjects];
    }
    if (!isAry(aryRequest)) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    [self.aryDatas addObjectsFromArray:aryRequest];
    [self.tableView reloadData];
}
@end
