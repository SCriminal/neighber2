//
//  EHomeArchiveDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/29.
//Copyright © 2020 ping. All rights reserved.
//

#import "EHomeArchiveDetailVC.h"

@interface EHomeArchiveDetailVC ()
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) EHomeArchiveDetailHouseView *houseView;
@property (nonatomic, strong) EHomeArchiveDetailOwnerView *ownerView;
@property (nonatomic, strong) EHomeArchiveDetailMemberView *memberView;

@end

@implementation EHomeArchiveDetailVC
- (EHomeArchiveDetailOwnerView *)ownerView{
    if (!_ownerView) {
        _ownerView = [EHomeArchiveDetailOwnerView new];
    }
    return _ownerView;
}
- (EHomeArchiveDetailHouseView *)houseView{
    if (!_houseView) {
        _houseView = [EHomeArchiveDetailHouseView new];
    }
    return _houseView;
}
- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [UIView new];
        _tableHeaderView.width = SCREEN_WIDTH;
        _tableHeaderView.backgroundColor = [UIColor clearColor];
    }
    return _tableHeaderView;
}
- (EHomeArchiveDetailMemberView *)memberView{
    if (!_memberView) {
        _memberView = [EHomeArchiveDetailMemberView new];
    }
    return _memberView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[EHomeArchiveDetailCell class] forCellReuseIdentifier:@"EHomeArchiveDetailCell"];
    //request
    [self requestList];
    [self reconfigView];

}
- (void)reconfigView{
    [self.tableHeaderView removeAllSubViews];
    //auto sc
    
    CGFloat top = 0;
        
    self.houseView.top = top;
       [self.tableHeaderView addSubview:self.houseView];
       top = self.houseView.bottom;
    
    self.ownerView.top = top;
       [self.tableHeaderView addSubview:self.ownerView];
       top = self.ownerView.bottom;

    if (self.aryDatas.count) {
        self.memberView.top = top;
              [self.tableHeaderView addSubview:self.memberView];
              top = self.memberView.bottom;
    }
   

    
    self.tableHeaderView.height = top ;
    self.tableView.tableHeaderView = self.tableHeaderView;
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"档案信息" rightView:nil]];
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
    EHomeArchiveDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EHomeArchiveDetailCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [EHomeArchiveDetailCell fetchHeight:self.aryDatas[indexPath.row]];
}

#pragma mark request
- (void)requestList{
    self.aryDatas = @[@"",@""].mutableCopy;
    [self.tableView reloadData];
}
@end


@implementation EHomeArchiveDetailHouseView

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
        [self resetViewWithModel:nil];
    }
    return self;
}


#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeAllSubViews];//移除线
    //刷新view
     UILabel * l = [UILabel new];
     l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
     l.textColor = COLOR_333;
     l.backgroundColor = [UIColor clearColor];
     [l fitTitle:@"房屋信息" variable:SCREEN_WIDTH - W(30)];
     l.leftTop = XY(W(15), W(20));
     [self addSubview:l];
     
     UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"EHomeHouse"];
        iv.widthHeight = XY(W(66),W(66));
    iv.leftTop = XY(W(14.5), l.bottom + W(14.5));
        [self addSubview:iv];


     
    
     l = [UILabel new];
     l.font = [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
     l.textColor = COLOR_333;
     [l fitTitle:@"金都时代小区（山东-潍坊-奎文区）" variable:W(240)];
     l.leftTop = XY(iv.right + W(14.5), iv.top + W(1));
     [self addSubview:l];

     l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        [l fitTitle:@"3号楼 2单元 402室" variable:W(240)];
        l.leftTop = XY(iv.right + W(14.5), iv.top + W(28));
        [self addSubview:l];
     
     l = [UILabel new];
          l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
          l.textColor = COLOR_666;
          [l fitTitle:@"红色物业服务有限公司" variable:W(200)];
          l.leftBottom = XY(iv.right + W(14.5), iv.bottom - W(2));
          [self addSubview:l];
     
     
     self.height = iv.bottom + W(19.5);
     [self addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];

     iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"map_phone"];
        iv.widthHeight = XY(W(20),W(20));
     iv.rightBottom = XY(SCREEN_WIDTH - W(20),self.height - W(20));
        [self addSubview:iv];

     [self addControlFrame:CGRectInset(iv.frame, -W(20), -W(20)) target:self action:@selector(phoneClick)];

}

- (void)phoneClick{
    
}
@end

@implementation EHomeArchiveDetailOwnerView

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
        [self resetViewWithModel:nil];
    }
    return self;
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeAllSubViews];//移除线
    //刷新view
     UILabel * l = [UILabel new];
     l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
     l.textColor = COLOR_333;
     l.backgroundColor = [UIColor clearColor];
     [l fitTitle:@"本人声明" variable:SCREEN_WIDTH - W(30)];
     l.leftTop = XY(W(15), W(20));
     [self addSubview:l];
     
     UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:IMAGE_HEAD_DEFAULT];
        iv.widthHeight = XY(W(50),W(50));
    iv.leftTop = XY(W(14.5), l.bottom + W(14.5));
        [self addSubview:iv];


     
    
     l = [UILabel new];
     l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
     l.textColor = COLOR_333;
     [l fitTitle:@"金都时代小区（山东-潍坊-奎文区）" variable:W(200)];
     l.leftTop = XY(iv.right + W(14.5), iv.top + W(3));
     [self addSubview:l];
    {
        UILabel * l1 = [UILabel new];
        l1.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l1.textColor = [UIColor whiteColor];
        l1.backgroundColor = COLOR_ORANGE;
        l1.textAlignment = NSTextAlignmentCenter;
        l1.text = @"业主";
        l1.widthHeight = XY(W(35), W(18));
        l1.leftCenterY = XY(l.right + W(5), l.centerY);
        [self addSubview:l1];
    }

     l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        [l fitTitle:@"身份证：3707031989092209" variable:W(240)];
        l.leftTop = XY(iv.right + W(14.5), iv.top + W(30));
        [self addSubview:l];
     
     l = [UILabel new];
          l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
          l.textColor = COLOR_666;
          [l fitTitle:@"手机：16789923888" variable:W(200)];
          l.leftTop = XY(iv.right + W(14.5), iv.bottom + W(5));
          [self addSubview:l];
    
    l = [UILabel new];
             l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
             l.textColor = COLOR_666;
             [l fitTitle:@"职业：职员" variable:W(200)];
    l.leftTop = XY(iv.right + W(14.5), iv.bottom + W(30.5));
             [self addSubview:l];
    
    l = [UILabel new];
               l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
               l.textColor = COLOR_666;
               [l fitTitle:@"企业：山东绿园科技有限公司" variable:W(200)];
      l.leftTop = XY(iv.right + W(14.5), iv.bottom + W(55.5));
               [self addSubview:l];
     
     
     self.height = l.bottom + W(20);
     [self addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];

     [self addControlFrame:CGRectInset(iv.frame, -W(20), -W(20)) target:self action:@selector(phoneClick)];

}

- (void)phoneClick{
    
}
@end


@implementation EHomeArchiveDetailMemberView

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
        [self resetViewWithModel:nil];
    }
    return self;
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeAllSubViews];//移除线
    //刷新view
     UILabel * l = [UILabel new];
     l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
     l.textColor = COLOR_333;
     l.backgroundColor = [UIColor clearColor];
     [l fitTitle:@"成员信息" variable:SCREEN_WIDTH - W(30)];
     l.leftTop = XY(W(15), W(20));
     [self addSubview:l];
     
    self.height = l.bottom + W(10);
}

@end


@implementation EHomeArchiveDetailCell
#pragma mark 懒加载
- (UIImageView *)logo{
    if (_logo == nil) {
        _logo = [UIImageView new];
        _logo.image = [UIImage imageNamed:IMAGE_HEAD_DEFAULT];
        _logo.widthHeight = XY(W(30),W(30));
    }
    return _logo;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _name;
}
-(UIButton *)btnConfirm{
    if (_btnConfirm == nil) {
        _btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnConfirm.tag = 1;
        [_btnConfirm addTarget:self action:@selector(btnConfirmClick) forControlEvents:UIControlEventTouchUpInside];
        _btnConfirm.backgroundColor = [UIColor colorWithHexString:@"#F0F9FF"];
        _btnConfirm.titleLabel.font = [UIFont systemFontOfSize:F(12)];
        [_btnConfirm setTitle:@"确认" forState:(UIControlStateNormal)];
        [_btnConfirm setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
        _btnConfirm.widthHeight = XY(W(47),W(25));
        [_btnConfirm addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:1 lineColor:COLOR_BLUE];

    }
    return _btnConfirm;
}
-(UIButton *)btnUnbind{
    if (_btnUnbind == nil) {
        _btnUnbind = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnUnbind.tag = 1;
        [_btnUnbind addTarget:self action:@selector(btnUnbindClick) forControlEvents:UIControlEventTouchUpInside];
        _btnUnbind.backgroundColor = COLOR_ORANGE;
        _btnUnbind.titleLabel.font = [UIFont systemFontOfSize:F(18)];
        [_btnUnbind setTitle:@"解除" forState:(UIControlStateNormal)];
        [_btnUnbind setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnUnbind.widthHeight = XY(W(47),W(25));
        [_btnUnbind addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];

    }
    return _btnUnbind;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.logo];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.btnConfirm];
    [self.contentView addSubview:self.btnUnbind];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
//    [self.logo sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    self.logo.leftTop = XY(W(15),W(10));
    [self.name fitTitle:@"张敏" variable:W(240)];
    self.name.leftCenterY = XY(self.logo.right + W(10),self.logo.centerY);

    self.btnConfirm.rightCenterY = XY(SCREEN_WIDTH - W(15),self.name.centerY);

    self.btnUnbind.leftTop = XY(SCREEN_WIDTH - W(15),self.name.centerY);
    self.btnConfirm.hidden = true;
    //设置总高度
    self.height = self.logo.bottom + W(10);
}
#pragma mark 点击事件
- (void)btnConfirmClick{
  
}
- (void)btnUnbindClick{
  
}
@end
