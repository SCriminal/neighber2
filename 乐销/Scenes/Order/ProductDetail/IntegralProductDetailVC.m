//
//  IntegralProductDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/27.
//Copyright © 2020 ping. All rights reserved.
//

#import "IntegralProductDetailVC.h"
//subview
#import "IntegralProductDetailView.h"
#import "YellowButton.h"
#import "AutoScView.h"
//request
#import "RequestApi+Neighbor.h"
// select vc
#import "SelectAddressVC.h"

@interface IntegralProductDetailVC ()<UIWebViewDelegate>
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) IntegralProductDetailView *titleView;
@property (nonatomic, strong) UIView *viewBottom;
@property (nonatomic, strong) AutoScView *autoSCView;
@property (nonatomic, strong) ModelIntegralProduct *modelDetail;
@property (strong, nonatomic) UIWebView *webDetail;

@end

@implementation IntegralProductDetailVC
- (UIWebView *)webDetail{
    if (!_webDetail) {
        _webDetail = [UIWebView new];
        _webDetail.delegate = self;
        _webDetail.width = SCREEN_WIDTH;
        _webDetail.height = 1;
        _webDetail.left = 0;
        _webDetail.scrollView.showsVerticalScrollIndicator = false;
        _webDetail.scrollView.showsHorizontalScrollIndicator = false;
        _webDetail.scrollView.scrollEnabled = false;
    }
    return _webDetail;
}
- (UIView *)viewBottom{
    if (!_viewBottom) {
        _viewBottom = [UIView new];
        _viewBottom.backgroundColor = [UIColor clearColor];
        {
            WEAKSELF
            YellowButton *btn = [YellowButton new];
            [btn resetViewWithWidth:W(335) :W(45) :@"立即兑换"];
            btn.blockClick = ^{
                SelectAddressVC * vc = [[SelectAddressVC alloc]init];
                vc.integralProductID = weakSelf.integralProductID;
                [GB_Nav pushViewController:vc animated:true];
            };
            btn.centerXTop = XY(SCREEN_WIDTH/2.0, W(15));
            [_viewBottom addSubview:btn];
        }
        _viewBottom.widthHeight = XY(SCREEN_WIDTH, W(60) + W(15)+iphoneXBottomInterval);
        _viewBottom.bottom = SCREEN_HEIGHT;
    }
    return _viewBottom;
}
- (IntegralProductDetailView *)titleView{
    if (!_titleView) {
        _titleView = [IntegralProductDetailView new];
    }
    return _titleView;
}
- (UIView *)header{
    if (!_header) {
        _header = [UIView new];
        _header.backgroundColor = [UIColor whiteColor];
    }
    return _header;
}

- (AutoScView *)autoSCView{
    if (!_autoSCView) {
        _autoSCView = [[AutoScView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, W(323)) image:@[]];
        _autoSCView.pageCurrentColor = [UIColor whiteColor];
        _autoSCView.pageDefaultColor = [UIColor colorWithHexString:@"ffffff" alpha:0.5];
        _autoSCView.pageControlToBottom = W(30);
//        _autoSCView.isClickValid = true;
        [_autoSCView timerStart];
    }
    return _autoSCView;
}

- (BaseNavView *)nav{
    if (!_nav) {
        _nav = [BaseNavView initNavTitle:@"" leftImageName:@"nav_black_back" leftImageSize:CGSizeMake(W(30), W(30)) leftBlock:^{
            [GB_Nav popViewControllerAnimated:true];
        } rightImageName:nil rightImageSize:CGSizeZero righBlock:nil];
        _nav.backgroundColor = [UIColor clearColor];
    }
    return _nav;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.viewBottom];
    //table
    self.tableView.top = 0;
    self.tableView.height = SCREEN_HEIGHT- self.viewBottom.height;
//    [self.tableView registerClass:[<#CellName#> class] forCellReuseIdentifier:@"<#CellName#>"];
    //request
    [self requestDetail];
}


- (void)config{
    [self.header removeAllSubViews];
    [self.autoSCView resetWithImageAry:self.modelDetail.urls];
    [self.header addSubview:self.autoSCView];
    [self.header addSubview:^(){
         UIImageView * ivWhiteBG = [UIImageView new];
                   ivWhiteBG.image = [UIImage imageNamed:@"signin_whiteBG"];
                   ivWhiteBG.widthHeight = XY(SCREEN_WIDTH, W(15));
        ivWhiteBG.bottom = self.autoSCView.bottom;
                   return ivWhiteBG;
    }()];
    [self.header addSubview:self.nav];
    self.titleView.top = self.autoSCView.bottom;
    [self.header addSubview:self.titleView];
    
    self.webDetail.top = self.titleView.bottom;
    [self.header addSubview:self.webDetail];
    self.header.height = self.webDetail.bottom;
    self.tableView.tableHeaderView = self.header;
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat webViewHeight1 = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    webView.frame = CGRectMake(webView.frame.origin.x,webView.frame.origin.y, SCREEN_WIDTH, webViewHeight1);
    self.header.height = self.webDetail.bottom;
    self.tableView.tableHeaderView = self.header;
    
}


#pragma mark request
- (void)requestDetail{
    [RequestApi requestIntegralProductDetailWithId:self.integralProductID delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelDetail = [ModelIntegralProduct modelObjectWithDictionary:response];
        [self.titleView resetViewWithModel:self.modelDetail];
        
        [self.webDetail loadHTMLString:[UnPackStr(self.modelDetail.body) fitWebImage] baseURL:nil];
        [self config];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}



@end
