//
//  OrderListManagementVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "OrderListManagementVC.h"
//滑动view
#import "switchView.h"
//list vc
#import "OrderListVC.h"
#import "IntegralOrderListVC.h"
//switch view
#import "SwitchView.h"

@interface OrderListManagementVC ()<UIScrollViewDelegate>
@property (strong, nonatomic) SwitchView *switchView;
@property (nonatomic, strong) UIScrollView *scAll;

@end

@implementation OrderListManagementVC
- (UIScrollView *)scAll{
    if (_scAll == nil) {
        _scAll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.switchView.bottom , SCREEN_WIDTH, SCREEN_HEIGHT - self.switchView.bottom)];
        _scAll.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
        _scAll.backgroundColor = [UIColor clearColor];
        _scAll.delegate = self;
        _scAll.pagingEnabled = true;
        _scAll.showsVerticalScrollIndicator = false;
        _scAll.showsHorizontalScrollIndicator = false;
    }
    return _scAll;
}
- (SwitchView *)switchView{
    if (_switchView == nil) {
        _switchView =  [SwitchView new];
        [_switchView resetViewWith:@"采购订单" :@"积分订单"];
        _switchView.centerXTop = XY(SCREEN_WIDTH/2.0, NAVIGATIONBAR_HEIGHT + W(15));
        WEAKSELF
        _switchView.blockClick = ^(int index) {
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.scAll.contentOffset = CGPointMake(SCREEN_WIDTH * index, 0);
                
            } completion:^(BOOL finished) {
                
            }];
        };
    }
    return _switchView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.scAll];
    [self.view addSubview:self.switchView];
    [self setupChildVC];
    if (self.isIntegral) {
        [self.switchView switchToIndex:1];
        self.scAll.contentOffset = CGPointMake(SCREEN_WIDTH * 1, 0);
    }
}
- (void)setupChildVC
{
    OrderListVC *sourceVC = [[OrderListVC alloc] init];
    sourceVC.view.frame = CGRectMake(0, 0, self.scAll.width, self.scAll.height);
    sourceVC.tableView.height = sourceVC.view.height;
    [self addChildViewController:sourceVC];
    [self.scAll addSubview:sourceVC.view];
    
    IntegralOrderListVC *integralOrderVC = [[IntegralOrderListVC alloc]init];
    integralOrderVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, self.scAll.width, self.scAll.height);
    integralOrderVC.tableView.height = sourceVC.view.height;
    [self addChildViewController:integralOrderVC];
    [self.scAll addSubview:integralOrderVC.view];
    
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"我的订单" rightView:nil]];
}
#pragma mark scrollview delegat
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self fetchCurrentView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self fetchCurrentView];
    }
}
- (void)fetchCurrentView {
    // 获取已经滚动的比例
    double ratio = self.scAll.contentOffset.x / SCREEN_WIDTH;
    int    page  = (int)(ratio + 0.5);
    // scrollview 到page页时 将toolbar调至对应按钮
    [self.switchView switchToIndex:page];
}

@end
