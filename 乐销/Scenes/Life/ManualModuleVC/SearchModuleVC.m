//
//  SearchModuleVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "SearchModuleVC.h"
#import "PartyMapView.h"
//request
#import "RequestApi+Neighbor.h"
@interface SearchModuleVC ()
@property (nonatomic, strong) PartyMapSearchView *searchView;
@property (nonatomic, strong) NSString *name;

@end

@implementation SearchModuleVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_module" title:@"搜索你感兴趣的应用"];
    }
    return _noResultView;
}
- (PartyMapSearchView *)searchView{
    if (!_searchView) {
        _searchView = [PartyMapSearchView new];
        _searchView.tfSearch.placeholder = @"搜索您感兴趣的应用";
        WEAKSELF
        _searchView.blockSearch = ^(NSString *str) {
            weakSelf.name = str;
            [weakSelf refreshHeaderAll];
        };
    }
    return _searchView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[SearchModuleCell class] forCellReuseIdentifier:@"SearchModuleCell"];
    //request
    [self showNoResult];
    [self addRefresh];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:self.searchView];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchModuleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SearchModuleCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SearchModuleCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelModule *model = self.aryDatas[indexPath.row];
    [ModelModule jumpWithModule:model];
}
#pragma mark request
- (void)requestList{
    [RequestApi requestModuleListWithAreaid:[GlobalData sharedInstance].community.iDProperty name:self.searchView.tfSearch.text  page:self.pageNum count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelModule"];
        if (self.isRemoveAll) {
            [self.aryDatas removeAllObjects];
        }
        if (!isAry(aryRequest)) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.aryDatas addObjectsFromArray:aryRequest];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
@end



@implementation SearchModuleCell
#pragma mark 懒加载
- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [UIImageView new];
        _icon.image = [UIImage imageNamed:@"zzrs_qyzz"];
        _icon.widthHeight = XY(W(40),W(40));
    }
    return _icon;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _name;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.name];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelModule *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    UIImage * image = [UIImage imageNamed:model.iconUrl];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:image?image:[UIImage imageNamed:@"default_module"]];
    self.icon.leftTop = XY(W(20), W(15));
    
    [self.name  fitTitle:model.moduleName  variable:0];
    self.name.leftCenterY = XY(self.icon.right + W(15),self.icon.centerY);
    
    
    //设置总高度
    self.height = [self.contentView addLineFrame:CGRectMake(W(15), self.icon.bottom + W(15), SCREEN_WIDTH - W(15), 1)];
}

@end
