//
//  ResumeSelfIntroduceVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/13.
//Copyright © 2020 ping. All rights reserved.
//

#import "ResumeSelfIntroduceVC.h"
#import "ResumeSelfIntroduceView.h"
#import "YellowButton.h"
#import "RequestApi+FindJob.h"

@interface ResumeSelfIntroduceVC ()
@property (nonatomic, strong) ResumeSelfIntroduceView *textView;
@property (nonatomic, strong) UIView  *viewBottom;

@end

@implementation ResumeSelfIntroduceVC
- (UIView *)viewBottom{
    if (!_viewBottom) {
        _viewBottom = [UIView new];
        _viewBottom.width = SCREEN_WIDTH;
        _viewBottom.backgroundColor = [UIColor clearColor];
        YellowButton * _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"保存"];
        WEAKSELF
        _btnBottom.blockClick = ^{
            [weakSelf requestSave];
        };
        [_viewBottom addSubview:_btnBottom];
        _btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0, W(18));
        _viewBottom.height = _btnBottom.bottom + W(10)+ iphoneXBottomInterval;
        _viewBottom.top = SCREEN_HEIGHT - _viewBottom.height;
    }
    return _viewBottom;
}
- (ResumeSelfIntroduceView *)textView{
    if (!_textView) {
        _textView = [ResumeSelfIntroduceView new];
        [_textView.problemDescription fitTitle:@"最多输入500字" variable:0];
        [_textView.textView.placeHolder fitTitle:@"请输入自我描述" variable:0];
        _textView.textView.text = self.modelResumeDetail.specialty;
    }
    return _textView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
//    [self.tableView registerClass:[<#CellName#> class] forCellReuseIdentifier:@"<#CellName#>"];
    self.tableView.backgroundColor = COLOR_GRAY;
    self.tableView.tableHeaderView = self.textView;
    self.tableView.tableFooterView = self.viewBottom;
    [self addObserveOfKeyboard];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"自我描述修改" rightView:nil]];
}

- (void)requestSave{
    [GlobalMethod endEditing];
  
    if (!isStr(self.textView.textView.text)) {
        [GlobalMethod showAlert:@"请输入自我描述"];
        return;
    }
    [RequestApi requestFJResumeIntroducepid:self.modelResumeDetail.iDProperty.doubleValue specialty:self.textView.textView.text delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"添加成功"];
        [GB_Nav popViewControllerAnimated:true];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
   
}

@end
