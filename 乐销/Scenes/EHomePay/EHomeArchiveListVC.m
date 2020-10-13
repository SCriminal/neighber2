//
//  EHomeArchiveListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/29.
//Copyright © 2020 ping. All rights reserved.
//

#import "EHomeArchiveListVC.h"
//yellow btn
#import "YellowButton.h"
#import "CreateArchiveVC.h"

@interface EHomeArchiveListVC ()
@property (nonatomic, strong) YellowButton *btnBottom;

@end

@implementation EHomeArchiveListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_archive" title:@"暂无档案信息"];
    }
    return _noResultView;
}
- (YellowButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"+ 建档"];
        _btnBottom.centerXBottom = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT - W(25)-iphoneXBottomInterval);
        WEAKSELF
        _btnBottom.blockClick = ^{
            CreateArchiveVC * vc = [CreateArchiveVC new];
            vc.blockBack = ^(UIViewController *vc) {
                [weakSelf refreshHeaderAll];
            };
            [GB_Nav pushViewController:vc animated:true];
        };
    }
    return _btnBottom;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[EHomeArchiveListCell class] forCellReuseIdentifier:@"EHomeArchiveListCell"];
    //request
    [self requestList];
    self.tableView.height = self.btnBottom.top - W(15) - NAVIGATIONBAR_HEIGHT;
    [self.view addSubview:self.btnBottom];

}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"居住档案" rightView:nil]];
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
    EHomeArchiveListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EHomeArchiveListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [EHomeArchiveListCell fetchHeight:self.aryDatas[indexPath.row]];
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
    self.aryDatas = @[@"",@""].mutableCopy;
    [self.tableView reloadData];
}
@end



@implementation EHomeArchiveListCell
#pragma mark 懒加载
- (UIImageView *)iconLogo{
    if (_iconLogo == nil) {
        _iconLogo = [UIImageView new];
        _iconLogo.image = [UIImage imageNamed:@"EHome_lessee"];
        _iconLogo.widthHeight = XY(W(50),W(50));
    }
    return _iconLogo;
}
- (UIImageView *)iconSelected{
    if (_iconSelected == nil) {
        _iconSelected = [UIImageView new];
        _iconSelected.image = [UIImage imageNamed:@"select_highlighted"];
        _iconSelected.widthHeight = XY(W(19),W(19));
    }
    return _iconSelected;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _name;
}
- (UILabel *)address{
    if (_address == nil) {
        _address = [UILabel new];
        _address.textColor = COLOR_999;
        _address.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _address;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconLogo];
    [self.contentView addSubview:self.iconSelected];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.address];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    //[self.iconLogo sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    self.iconLogo.leftTop = XY(W(15),W(15));

   // [self.iconSelected sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    self.iconSelected.rightCenterY = XY(SCREEN_WIDTH - W(15),self.iconLogo.centerY+W(0));
    [self.name fitTitle:@"业主" variable:W(230)];
    self.name.leftTop = XY(self.iconLogo.right + W(10),self.iconLogo.top+W(3.5));
    [self.address fitTitle:@"金都时代城小区 3号楼 2单元 402" variable:W(230)];
    self.address.leftBottom = XY(self.iconLogo.right + W(10),self.iconLogo.bottom-W(3.5));

    //设置总高度
    self.height = self.iconLogo.bottom + W(15);
}

@end
