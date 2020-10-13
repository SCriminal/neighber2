//
//  JournalismDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "JournalismDetailVC.h"
//request
#import "RequestApi+Neighbor.h"
@interface JournalismDetailVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *web;

@end

@implementation JournalismDetailVC


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
    [self.view addSubview:[BaseNavView initNavBackTitle:@"详情" rightView:nil]];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.loadingView hideLoading];
    
    
}
- (void)requestDetail{
    [self showLoadingView];
#ifdef DEBUG
//    NSString * strURL = [NSString stringWithFormat:@"http://192.168.20.172:8883/community/news/detail?id=%.f",self.model.iDProperty];
    NSString * strURL = [NSString stringWithFormat:@"https://wsq.hongjiafu.cn/community/news/detail?id=%.f",self.model.iDProperty];
#else
    NSString * strURL = [NSString stringWithFormat:@"https://wsq.hongjiafu.cn/community/news/detail?id=%.f",self.model.iDProperty];
#endif
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strURL]]];
}

@end
