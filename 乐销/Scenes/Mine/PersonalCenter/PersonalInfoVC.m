//
//  PersonalInfoVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/26.
//Copyright © 2020 ping. All rights reserved.
//

#import "PersonalInfoVC.h"
//request
#import "RequestApi+Neighbor.h"

@interface PersonalInfoVC ()
@property (nonatomic, strong) PersonalInfoView *infoView;

@end

@implementation PersonalInfoVC
- (PersonalInfoView *)infoView{
    if (!_infoView) {
        _infoView = [PersonalInfoView new];
    }
    return _infoView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableView.tableHeaderView = self.infoView;
}
- (void)viewDidAppear:(BOOL)animated{
    [self.infoView resetHeaderView];
    [super viewDidAppear:animated];
    [self requestList];
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"个人资料" rightView:nil]];
}

#pragma mark request
- (void)requestList{
    [RequestApi requestAuthenticationDetailWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelAuthentication * model = [ModelAuthentication modelObjectWithDictionary:response];
        [self.infoView resetAuthTitle:model.statusShow ];
        [self requestArchive];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestArchive{
    [RequestApi requestArchiveListWithPage:1 count:1 estateId:[GlobalData sharedInstance].community.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelArchiveList"];
        [self.infoView resetArchiveTitle:aryRequest.count?@"已建档":@"未建档" ];
        [self requestMember];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestMember{
    [RequestApi requestMemeberListWithPage:1 count:1 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        double total = [response doubleValueForKey:@"total"];
        [self.infoView resetMemeberTitle:[NSString stringWithFormat:@"%@成员",NSNumber.dou(total)]];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end



@implementation PersonalInfoView
#pragma mark 懒加载
- (UIImageView *)head{
    if (_head == nil) {
        _head = [UIImageView new];
        _head.widthHeight = XY(W(50),W(50));
        _head.image = [UIImage imageNamed:@"personal_head"];
              _head.contentMode = UIViewContentModeScaleAspectFill;
              _head.clipsToBounds = true;
              [_head addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:_head.width/2.0 lineWidth:0 lineColor:[UIColor clearColor]];
    }
    return _head;
}
- (UILabel *)authority{
    if (_authority == nil) {
        _authority = [UILabel new];
        _authority.textColor = COLOR_999;
        _authority.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
    }
    return _authority;
}
- (UILabel *)archive{
    if (_archive == nil) {
        _archive = [UILabel new];
        _archive.textColor = COLOR_999;
        _archive.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
    }
    return _archive;
}
- (UILabel *)memeber{
    if (_memeber == nil) {
        _memeber = [UILabel new];
        _memeber.textColor = COLOR_999;
        _memeber.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
    }
    return _memeber;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
   
    NSArray * aryTitle = @[@"基本信息",@"实名认证",@"居民建档",@"成员管理",@"收货地址"];
    NSArray * aryHeight = @[@86,@51,@51,@51,@51];
    CGFloat top = 0;
    for (int i = 0; i<aryTitle.count; i++) {
        NSString * title = aryTitle[i];
        double height = [aryHeight[i] doubleValue];
        
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.widthHeight = XY(SCREEN_WIDTH, W(height));
        view.leftTop = XY(0, top);
        view.tag = 100 +i;
        [self addSubview:view];
        [view addTarget:self action:@selector(click:)];
        [view addLineFrame:CGRectMake(W(15), view.height - 1, SCREEN_WIDTH - W(15), 1)];
        top = view.bottom;
        
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:title variable:SCREEN_WIDTH - W(30)];
        l.leftCenterY = XY(W(15), view.height/2.0);
        [view addSubview:l];
        
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"arrow_right"];
        iv.widthHeight = XY(W(15),W(15));
        iv.rightCenterY = XY(SCREEN_WIDTH - W(15),view.height/2.0);
        [view addSubview:iv];
    }
    [self addSubview:self.head];
       [self addSubview:self.authority];
       [self addSubview:self.archive];
       [self addSubview:self.memeber];
    [self resetHeaderView];
    //初始化页面
    self.height = top;
}
- (void)click:(UITapGestureRecognizer *)tap{
    switch (tap.view.tag-100) {
        case 0:
        {
            [GB_Nav pushVCName:@"EditInfoVC" animated:true];
        }
            break;
        case 1:
        {
            [GB_Nav pushVCName:@"AuthenticationVC" animated:true];
            
        }
            break;
        case 2:
        {
            [GB_Nav pushVCName:@"ArchiveListVC" animated:true];
            
        }
            break;
        case 3:
        {
            [GB_Nav pushVCName:@"MemberListVC" animated:true];
            
            
        }
            break;
        case 4:
        {
            [GB_Nav pushVCName:@"AddressListVC" animated:true];

        }
            break;
        default:
            break;
    }
}

#pragma mark 刷新view
- (void)resetHeaderView{
    self.head.rightCenterY = XY(SCREEN_WIDTH - W(37), W(86)/2.0);
    ModelUser * model = [GlobalData sharedInstance].GB_UserModel;
    [self.head sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"personal_head"]];
}

- (void)resetAuthTitle:(NSString *)title {
    [self.authority fitTitle:title variable:0];
    self.authority.rightCenterY = XY(SCREEN_WIDTH - W(37),W(86) + W(51)/2.0);
}

- (void)resetArchiveTitle:(NSString *)title {
    [self.archive fitTitle:title variable:0];
    self.archive.rightCenterY = XY(SCREEN_WIDTH - W(37),W(138) + W(51)/2.0);
}

- (void)resetMemeberTitle:(NSString *)title {
    [self.memeber fitTitle:title variable:0];
    self.memeber.rightCenterY = XY(SCREEN_WIDTH - W(37),W(190) + W(51)/2.0);
}
@end
