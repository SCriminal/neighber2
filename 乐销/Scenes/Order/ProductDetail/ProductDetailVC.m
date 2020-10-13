//
//  ProductDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "ProductDetailVC.h"
//subview
#import "ProductDetailView.h"
#import "YellowButton.h"
#import "AutoScView.h"
//request
#import "RequestApi+Neighbor.h"
#import "ConfirmOrderVC.h"

@interface ProductDetailVC ()<UIWebViewDelegate>
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) ProductDetailTitleView *titleView;
@property (nonatomic, strong) UIView *viewBottom;
@property (nonatomic, strong) AutoScView *autoSCView;
@property (nonatomic, strong) ModelIntegralProduct *modelDetail;
@property (strong, nonatomic) UIWebView *webDetail;

@end

@implementation ProductDetailVC
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
        _viewBottom.clipsToBounds = true;

        WEAKSELF
        {
            YellowButton *btn = [YellowButton new];
            [btn resetYellowHollowViewWithWidth:W(160) :W(45) :@"加入购物车"];
            btn.blockClick = ^{
                [GlobalMethod judgeLoginState:^{
                    [weakSelf requestAdd:weakSelf.code];
                }];
            };
            btn.leftTop = XY(W(20), W(15));
            [_viewBottom addSubview:btn];
        }
        {
            YellowButton *btn = [YellowButton new];
            [btn resetViewWithWidth:W(160) :W(45) :@"立即购买"];
            btn.blockClick = ^{
                [GlobalMethod judgeLoginState:^{
                    ConfirmOrderVC * confirmVC = [ConfirmOrderVC new];
                    confirmVC.aryDatas = @[^(){
                        ModelTrolley * item = [ModelTrolley new];
                        item.name = weakSelf.modelShop.storeName;
                        ModelIntegralProduct * pro =[ModelIntegralProduct modelObjectWithDictionary:weakSelf.modelDetail.dictionaryRepresentation];
                        pro.qty = 1;
                        item.skus = @[pro].mutableCopy;
                        return item;
                    }()].mutableCopy;
                    [GB_Nav pushViewController:confirmVC animated:true];
                }];
            };
            btn.rightTop = XY(SCREEN_WIDTH - W(20), W(15));
            [_viewBottom addSubview:btn];
        }
        _viewBottom.widthHeight = XY(SCREEN_WIDTH, W(60) + W(15)+iphoneXBottomInterval);
        _viewBottom.bottom = SCREEN_HEIGHT;
        #ifdef UP_APP_STORE
                _viewBottom.height = 0;
        #endif
    }
    return _viewBottom;
}
- (ProductDetailTitleView *)titleView{
    if (!_titleView) {
        _titleView = [ProductDetailTitleView new];
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
//        _autoSCView.isClickValid = true;
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
    [self.autoSCView resetWithImageAry:@[self.modelDetail.coverUrl]];
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
    [RequestApi requestProductDetailWithCode:self.code delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelDetail = [ModelIntegralProduct modelObjectWithDictionary:response];
        [self.titleView resetViewWithModel:self.modelDetail];

        [self.webDetail loadHTMLString:[UnPackStr(self.modelDetail.body) fitWebImage] baseURL:nil];
        [self config];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestAdd:(NSString *)code{
    [RequestApi requestAddTrolleyWithId:code qty:1 scope:@"" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"添加成功"];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
