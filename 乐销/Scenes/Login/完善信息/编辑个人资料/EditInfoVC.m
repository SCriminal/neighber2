//
//  EditInfoVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "EditInfoVC.h"
//keyboard observe
#import "BaseTableVC+KeyboardObserve.h"
#import "BaseVC+BaseImageSelectVC.h"
//上传图片
#import "AliClient.h"
#import "BaseTableVC+Authority.h"
#import "YellowButton.h"
//request
#import "RequestApi+Neighbor.h"
@interface EditInfoVC ()
@property (nonatomic, strong) EditInfoTopView *topView;
@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelPhone;
@property (nonatomic, strong) ModelBaseData *modelAddress;
@property (nonatomic, strong) YellowButton  *btnBottom;

@end

@implementation EditInfoVC

#pragma mark lazy init
- (YellowButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"更新"];
        WEAKSELF
        _btnBottom.blockClick = ^{
            [weakSelf requestEdit];
        };
    }
    return _btnBottom;
}
- (EditInfoTopView *)topView{
    if (!_topView) {
        _topView = [EditInfoTopView new];
        WEAKSELF
        _topView.blockClick = ^{
            [weakSelf showImageVC:1];
        };
    }
    return _topView;
}
- (ModelBaseData *)modelName{
    if (!_modelName) {
        _modelName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"昵称";
            model.subString = [GlobalData sharedInstance].GB_UserModel.nickname;
            model.placeHolderString = @"请输入昵称";
            return model;
        }();
    }
    return _modelName;
}
- (ModelBaseData *)modelPhone{
    if (!_modelPhone) {
        _modelPhone = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"电话";
            model.placeHolderString = @"请输入联系电话";
            model.subString = [GlobalData sharedInstance].GB_UserModel.phone;
            return model;
        }();
    }
    return _modelPhone;
}
- (ModelBaseData *)modelAddress{
    if (!_modelAddress) {
        _modelAddress = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"地址";
            model.placeHolderString = @"请输入联系地址";
            model.subString = [GlobalData sharedInstance].GB_UserModel.addr;
            model.hideState = true;
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            return model;
        }();
    }
    return _modelAddress;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    //    self.tableView.tableHeaderView = self.topView;
    self.tableView.backgroundColor = COLOR_BACKGROUND;
    self.tableView.leftInterval = W(96);
    [self registAuthorityCell];
    self.tableView.tableHeaderView = self.topView;
    self.tableView.tableFooterView = ^(){
        UIView * footer = [UIView new];
        [footer addSubview:self.btnBottom];
        self.btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0, W(35));
        footer.widthHeight = XY(SCREEN_WIDTH, self.btnBottom.bottom);
        return footer;
    }();
    //config data
    [self configData];
    //add keyboard observe
    [self addObserveOfKeyboard];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView *nav = [BaseNavView initNavBackTitle:@"个人资料" rightTitle:@"" rightBlock:^{
    }];
    [self.view addSubview:nav];
}

#pragma mark config data
- (void)configData{
    
    self.aryDatas = @[ self.modelName,self.modelPhone,self.modelAddress].mutableCopy;
    [self.tableView reloadData];
}
#pragma mark image select
- (void)imageSelect:(BaseImage *)image{
    self.topView.ivHead.image = image;
    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_USER_LOGO;
    [[AliClient sharedInstance]updateImageAry:@[image] storageSuccess:^{
        
    } upSuccess:^{
        
    } fail:^{
        
    }];
}
#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self dequeueAuthorityCell:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self fetchAuthorityCellHeight:indexPath];
}
#pragma mark request
- (void)requestEdit{
    if (!isPhoneNum(self.modelPhone.subString)) {
        [GlobalMethod showAlert:@"请输入有效电话"];
        return;
    }
    [RequestApi requestEditPersonlInfoWithHeadurl:[BaseImage fetchUrl:self.topView.ivHead.image] nickname:self.modelName.subString phone:self.modelPhone.subString addr:self.modelAddress.subString gender:0 scope:0 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [RequestApi requestUserInfoWithScope:0 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalData sharedInstance].GB_UserModel = [ModelUser modelObjectWithDictionary:response];
            [GlobalMethod showAlert:@"修改成功"];
            [GB_Nav popViewControllerAnimated:true];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        } ];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end



@implementation EditInfoTopView
#pragma mark 懒加载
- (UIView *)viewWhiteBG{
    if (!_viewWhiteBG) {
        _viewWhiteBG = [UIView new];
        _viewWhiteBG.backgroundColor = [UIColor whiteColor];
        _viewWhiteBG.width = W(345);
        _viewWhiteBG.centerX = SCREEN_WIDTH/2.0;

    }
    return _viewWhiteBG;
}
- (UILabel *)labelInfo{
    if (_labelInfo == nil) {
        _labelInfo = [UILabel new];
        _labelInfo.textColor = COLOR_333;
        _labelInfo.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelInfo.numberOfLines = 0;
        _labelInfo.lineSpace = 0;
    }
    return _labelInfo;
}
- (UIImageView *)ivHead{
    if (_ivHead == nil) {
        _ivHead = [UIImageView new];
        WEAKSELF
        [_ivHead sd_setImageWithURL:[NSURL URLWithString:[GlobalData sharedInstance].GB_UserModel.headUrl] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error == nil && image) {
                weakSelf.ivHead.image = [BaseImage imageWithImage:image url:imageURL];
            }
        }];
        _ivHead.widthHeight = XY(W(50),W(50));
        [_ivHead addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:_ivHead.width/2.0 lineWidth:0 lineColor:[UIColor clearColor]];
    }
    return _ivHead;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_GRAY;
        self.width = SCREEN_WIDTH;
        [self addSubView];
        [self addTarget:self action:@selector(click)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewWhiteBG];
    [self addSubview:self.labelInfo];
    [self addSubview:self.ivHead];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    [self.labelInfo fitTitle:@"头像" variable:0];
    self.labelInfo.left = W(35);
    
    self.ivHead.leftTop = XY(W(96),W(13));

    
    self.labelInfo.centerY = self.ivHead.centerY;
    //设置总高度
    self.height = self.ivHead.bottom + W(13);
    [self addLineFrame:CGRectMake(W(35), self.height -1, SCREEN_WIDTH - W(70), 1)];
    
    self.viewWhiteBG.height = self.height;
    [self.viewWhiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
    

}

#pragma mark click
- (void)click{
    if (self.blockClick) {
        self.blockClick();
    }
}
@end
