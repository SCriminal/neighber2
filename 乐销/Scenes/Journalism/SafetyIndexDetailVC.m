//
//  SafetyIndexDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/6/29.
//Copyright © 2020 ping. All rights reserved.
//

#import "SafetyIndexDetailVC.h"
//request
#import "RequestApi+Neighbor.h"

@interface SafetyIndexDetailVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *web;
@property (nonatomic, strong) ModelNews *model;

@end

@implementation SafetyIndexDetailVC
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


- (UIWebView *)web{
    if (!_web) {
        _web = [UIWebView new];
        _web.delegate = self;
        _web.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
        if (@available(iOS 11.0, *)) {
              _web.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _web;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.web];
    [self requestDetail];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"平安指数" rightView:nil]];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.loadingView hideLoading];
}
- (void)requestDetail{
    [RequestApi requestNewsListWithScopeid:[GlobalData sharedInstance].community.iDProperty page:1 count:50 categoryAlias:@"safety_index" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelNews"];
        for (ModelNews * item in aryRequest.copy) {
                   if ([item.title containsString:@"疫情"]) {
                       [aryRequest removeObject:item];
                   }
               }
        if (aryRequest.count > 0) {
            [self.noResultView removeFromSuperview];
            [self showLoadingView];
            ModelNews * model = aryRequest.firstObject;
            self.model = model;
#ifdef DEBUG
//            NSString * strURL = [NSString stringWithFormat:@"http://192.168.20.172:8883/community/news/detail?id=%.f",model.iDProperty];
            NSString * strURL = [NSString stringWithFormat:@"https://wsq.hongjiafu.cn/community/news/detail?id=%.f",self.model.iDProperty];
#else
            NSString * strURL = [NSString stringWithFormat:@"https://wsq.hongjiafu.cn/community/news/detail?id=%.f",model.iDProperty];
#endif
            [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strURL]]];
        }else{
            [self showNoResult];
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        [self showNoResult];
    }];
}
- (void)showNoResult{
    [self.noResultLoadingView removeFromSuperview];
    [self.noResultView removeFromSuperview];
    
    if(!self.isShowNoResult)return;
    if (self.model.iDProperty) {
        return;
    }
    [self.noResultView showInView:self.view frame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT)];
}
@end
