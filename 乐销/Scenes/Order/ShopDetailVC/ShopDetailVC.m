//
//  ShopDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "ShopDetailVC.h"
//sub view
#import "ShopDetailView.h"
//cell
#import "ShopDetailCell.h"
//request
#import "RequestApi+Neighbor.h"
#import "ProductDetailVC.h"
#import "TrolleyBtn.h"
@interface ShopDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) ShopDetailTopView *topView;
@property (nonatomic, strong) UITableView *tableLeft;
@property (nonatomic, strong) UITableView *tableRight;
@property (nonatomic, strong) NSMutableArray *datasLeft;
@property (nonatomic, strong) NSArray *datasRight;
@property (nonatomic, strong) SearchDetailSearchView *searchView;
@property (nonatomic, strong) TrolleyBtn *btnTrolley;

@end

@implementation ShopDetailVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_product" title:@"暂无商品"];
    }
    return _noResultView;
}
- (TrolleyBtn *)btnTrolley{
    if (!_btnTrolley) {
        _btnTrolley = [TrolleyBtn new];
//        _btnTrolley.leftBottom = XY(W(5), SCREEN_HEIGHT - iphoneXBottomInterval - W(10));
        _btnTrolley.rightBottom = XY(SCREEN_WIDTH - W(5.5), SCREEN_HEIGHT - iphoneXBottomInterval - W(8));
//        _btnTrolley.hidden = true;
    }
    return _btnTrolley;
}
- (SearchDetailSearchView *)searchView{
    if (!_searchView) {
        _searchView = [SearchDetailSearchView new];
        _searchView.top = self.topView.bottom;
        _searchView.clipsToBounds = true;
        _searchView.height = 0;
    }
    return _searchView;
}
- (UITableView *)tableLeft{
    if (!_tableLeft) {
        _tableLeft = [[UITableView alloc]initWithFrame:CGRectMake(0, self.searchView.bottom, W(102.5), SCREEN_HEIGHT - self.searchView.bottom) style:UITableViewStyleGrouped];
        if (@available(iOS 11.0, *)) {
            _tableLeft.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableLeft.estimatedRowHeight = 0;
            _tableLeft.estimatedSectionFooterHeight = 0;
            _tableLeft.estimatedSectionHeaderHeight = 0;
        }
        _tableLeft.delegate = self;
        _tableLeft.dataSource = self;
        _tableLeft.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableLeft.backgroundColor = [UIColor whiteColor];
        _tableLeft.showsVerticalScrollIndicator = NO;
        _tableLeft.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableLeft;
}
- (UITableView *)tableRight{
    if (!_tableRight) {
        _tableRight = [[UITableView alloc]initWithFrame:CGRectMake(self.tableLeft.right, self.searchView.bottom, SCREEN_WIDTH - self.tableLeft.width, SCREEN_HEIGHT - self.searchView.bottom) style:UITableViewStyleGrouped];
        _tableRight.tag = 1;
        if (@available(iOS 11.0, *)) {
            _tableRight.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableRight.estimatedRowHeight = 0;
            _tableRight.estimatedSectionFooterHeight = 0;
            _tableRight.estimatedSectionHeaderHeight = 0;
        }
        _tableRight.delegate = self;
        _tableRight.dataSource = self;
        _tableRight.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableRight.backgroundColor = COLOR_GRAY;
        _tableRight.showsVerticalScrollIndicator = NO;
        _tableRight.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableRight.contentInset = UIEdgeInsetsMake(W(3), 0, 0, 0);
    }
    return _tableRight;
}
- (NSMutableArray *)datasLeft{
    if (!_datasLeft) {
        _datasLeft = [NSMutableArray new];
        
    }
    return _datasLeft;
}
- (NSArray *)datasRight{
    if (!_datasRight) {
        _datasRight = [NSMutableArray new];

    }
    return _datasRight;
}
- (ShopDetailTopView *)topView{
    if (!_topView) {
        _topView = [ShopDetailTopView new];
        _topView.top = NAVIGATIONBAR_HEIGHT;
        [_topView resetViewWithModel:self.modelShop];
    }
    return _topView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.searchView];
    //table
    [self.view addSubview:self.tableLeft];
    [self.view addSubview:self.tableRight];
    [self.view addSubview:self.btnTrolley];

    [self.tableLeft registerClass:[ShopDetailLeftCell class] forCellReuseIdentifier:@"ShopDetailLeftCell"];
    [self.tableRight registerClass:[ShopDetailRightCell class] forCellReuseIdentifier:@"ShopDetailRightCell"];
    
    [self addObserveOfKeyboard];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"商家中心" rightView:nil]];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.btnTrolley reconfig];
}
#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableView.tag==0?self.datasLeft.count:self.datasRight.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag ==0) {
        ShopDetailLeftCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ShopDetailLeftCell"];
        [cell resetCellWithModel:self.datasLeft[indexPath.row]];
        return cell;
    }
    ShopDetailRightCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ShopDetailRightCell"];
    [cell resetCellWithModel:self.datasRight[indexPath.row]];
    WEAKSELF
    cell.blockClick = ^(ModelShopDetailProduct *item) {
        [weakSelf requestAdd:item];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0) {
        return [ShopDetailLeftCell fetchHeight:self.datasLeft[indexPath.row]];
    }
    return [ShopDetailRightCell fetchHeight:self.datasRight[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0) {
        ModelShopDetailCategory *modelCategory = self.datasLeft[indexPath.row];
        self.datasRight = modelCategory.skuList;
        for (ModelShopDetailCategory *item in self.datasLeft) {
            item.isSelected = false;
        }
        modelCategory.isSelected = true;
        [self.tableLeft reloadData];
        [self.tableRight reloadData];
    }else{
        ModelShopDetailProduct * item = self.datasRight[indexPath.row];
        ProductDetailVC * detailVC = [ProductDetailVC new];
        detailVC.code = item.code;
        detailVC.modelShop = self.modelShop;
        [GB_Nav pushViewController:detailVC animated:true];
    }
}
//table header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
//table footer
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

#pragma mark request
- (void)requestList{
    [RequestApi requestShopProductWithscopeId:strDotF([GlobalData sharedInstance].community.iDProperty) storeId:self.modelShop.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelShopDetailCategory"];
        self.datasLeft = aryRequest;
        if (isAry(aryRequest)) {
            ModelShopDetailCategory * modelFirst = [aryRequest objectAtIndex:0];
            modelFirst.isSelected = true;
            [self tableView:self.tableLeft didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}


#pragma mark noresult after requst
- (void)showNoResult{
    [self.noResultLoadingView removeFromSuperview];
    [self.noResultView removeFromSuperview];
    
    if(!self.isShowNoResult)return;
    if (self.datasLeft.count == 0) {
        
        [self.noResultView showInView:self.view frame:CGRectMake(0, self.searchView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.searchView.bottom)];
    }
}
- (void)requestAdd:(ModelShopDetailProduct *)item{
    [RequestApi requestAddTrolleyWithId:item.code qty:1 scope:@"" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self.btnTrolley reconfig];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
