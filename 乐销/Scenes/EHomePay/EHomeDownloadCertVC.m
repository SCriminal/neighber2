//
//  EHomeDownloadCertVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/10/13.
//Copyright © 2020 ping. All rights reserved.
//

#import "EHomeDownloadCertVC.h"
//yellow btn
#import "YellowButton.h"
//shadowView
#import "ShadowView.h"

@interface EHomeDownloadCertVC ()
@property (nonatomic, strong) YellowButton *btnBottom;
@property (nonatomic, strong) UIView *tableHeaderView;

@end

@implementation EHomeDownloadCertVC
- (YellowButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"下载凭证"];
        _btnBottom.centerXBottom = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT - W(25)-iphoneXBottomInterval);
        WEAKSELF
        _btnBottom.blockClick = ^{
            [weakSelf saveImage];
        };
    }
    return _btnBottom;
}
- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [UIView new];
        _tableHeaderView.width = SCREEN_WIDTH;
        _tableHeaderView.backgroundColor = [UIColor clearColor];
    }
    return _tableHeaderView;
}

- (void)reconfigView{
    [self.tableHeaderView removeAllSubViews];
    //auto sc
    ShadowView *viewBG = [ShadowView new];
    [self.tableHeaderView addSubview:viewBG];
    
    CGFloat top = W(50);
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"缴费凭证" variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, top);
        [self.tableHeaderView addSubview:l];
        top = l.bottom;
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:[NSString stringWithFormat:@"￥%@",NSNumber.dou(self.modelDetail.payAmount).stringValue]  variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, top+ W(15));
        [self.tableHeaderView addSubview:l];
        top = l.bottom;
    }
    
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"缴费类型" variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(W(95), top + W(30));
        [self.tableHeaderView addSubview:l];
        
        UILabel * l1 = [UILabel new];
        l1.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        l1.textColor = COLOR_333;
        l1.backgroundColor = [UIColor clearColor];
        [l1 fitTitle:UnPackStr(self.modelDetail.feeStateName) variable:SCREEN_WIDTH - W(30)];
        l1.centerXTop = XY(l.centerX, l.bottom + W(15));
        [self.tableHeaderView addSubview:l1];
        
    }
    
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"缴费状态" variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(W(279), top + W(30));
        [self.tableHeaderView addSubview:l];
        
        UILabel * l1 = [UILabel new];
        l1.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        l1.textColor = COLOR_333;
        l1.backgroundColor = [UIColor clearColor];
        [l1 fitTitle:UnPackStr(self.modelDetail.payStatus) variable:SCREEN_WIDTH - W(30)];
        l1.centerXTop = XY(l.centerX, l.bottom + W(15));
        [self.tableHeaderView addSubview:l1];
        top = l1.bottom;
    }
    
    
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"EHomeLine"];
        iv.widthHeight = XY(W(306),W(2));
        iv.centerXTop = XY(SCREEN_WIDTH/2.0,top+W(24.5));
        [self.tableHeaderView addSubview:iv];
        top = iv.bottom+W(5);
    }
    
    NSArray * ary = @[^(){
        ModelBaseData * modelItem = [ModelBaseData new];
        modelItem.string = @"缴费房屋";
        modelItem.subString = [NSString stringWithFormat:@"%@/%@号楼/%@单元/%@室",self.modelDetail.areaName,self.modelDetail.floorName,self.modelDetail.unitNo,self.modelDetail.roomNo];
        return modelItem;
    }(),^(){
        ModelBaseData * modelItem = [ModelBaseData new];
        modelItem.string = @"缴费人";
        modelItem.subString = self.modelDetail.custName;
        return modelItem;
    }(),^(){
        ModelBaseData * modelItem = [ModelBaseData new];
        modelItem.string = @"支付时间";
        modelItem.subString = self.modelDetail.payDate;
        return modelItem;
    }(),^(){
        ModelBaseData * modelItem = [ModelBaseData new];
        modelItem.string = @"支付方式";
        modelItem.subString = self.modelDetail.payType;
        return modelItem;
    }(),^(){
        ModelBaseData * modelItem = [ModelBaseData new];
        modelItem.string = @"收费单位";
        modelItem.subString = self.modelDetail.receiveCompany;
        return modelItem;
    }()];
    for (int i = 0; i<ary.count; i++) {
        ModelBaseData * item = ary[i];
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:item.string variable:SCREEN_WIDTH - W(30)];
            l.rightTop = XY(W(92), top + W(20));
            [self.tableHeaderView addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(3);
            [l fitTitle:UnPackStr(item.subString) variable: W(224)];
            l.leftTop = XY(W(122), top + W(20));
            [self.tableHeaderView addSubview:l];
            top = l.bottom ;
        }
    }
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        [iv sd_setImageWithURL:[NSURL URLWithString:self.modelDetail.eleSignUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"aa");
        }];
        iv.widthHeight = XY(W(120),W(120));
        iv.rightTop = XY(SCREEN_WIDTH - W(20),W(300));
        [self.tableHeaderView addSubview:iv];
    }
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"EHomeLine"];
        iv.widthHeight = XY(W(306),W(2));
        iv.centerXTop = XY(SCREEN_WIDTH/2.0,top+W(25));
        [self.tableHeaderView addSubview:iv];
        top = iv.bottom+W(5);
    }
    
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_999;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(5);
        [l fitTitle:@"本凭证仅作为记账核算凭证使用，纳税人如需正式完税证明，请凭身份证明到主管税务机构" variable: W(300)];
        l.leftTop = XY(W(35), top + W(20));
        [self.tableHeaderView addSubview:l];
        top = l.bottom ;
    }
    
    [viewBG resetViewWith:CGRectMake(W(15), W(30), SCREEN_WIDTH - W(30), top + W(25))];

    self.tableHeaderView.height = top+W(40) ;
    self.tableView.tableHeaderView = self.tableHeaderView;
}


#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //request
    [self requestList];
    self.tableView.height = self.btnBottom.top - W(15) - NAVIGATIONBAR_HEIGHT;
    [self.view addSubview:self.btnBottom];
    
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"缴费凭证" rightView:nil]];
}

#pragma mark request
- (void)requestList{
    [self reconfigView];
}

- (void)saveImage{
    UIImage * qrImage = [UIImage captureImageFromView:self.tableHeaderView];
           [GlobalMethod fetchPhotoAuthorityBlock:^{
               UIImageWriteToSavedPhotosAlbum(qrImage, self, @selector(image: didFinishSavingWithError:contextInfo:), nil);
           }];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [GlobalMethod showAlert:[NSString stringWithFormat:@"写入相册失败%@",error]];
    } else {
        [GlobalMethod showAlert:@"写入相册成功"];
    }
}
@end

