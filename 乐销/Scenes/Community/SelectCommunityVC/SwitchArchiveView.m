//
//  SwitchArchiveView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/22.
//Copyright © 2020 ping. All rights reserved.
//

#import "SwitchArchiveView.h"

@interface SwitchArchiveView ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *BG;
@property (nonatomic, strong) NSMutableArray *aryDatas;
@property (nonatomic, strong) UIControl *con;
@property (nonatomic, strong) UIControl *conTop;
@property (nonatomic, strong) UIView *blackBG;

@end

@implementation SwitchArchiveView

- (UIControl *)conTop{
    if (!_conTop) {
        _conTop = [UIControl new];
        _conTop.width = SCREEN_WIDTH;
        _conTop.height = NAVIGATIONBAR_HEIGHT;
        _conTop.backgroundColor = [UIColor clearColor];
        [_conTop addTarget:self action:@selector(removeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _conTop;
}
- (UIControl *)con{
    if (!_con) {
        _con = [UIControl new];
        _con.width = SCREEN_WIDTH;
        _con.height = SCREEN_HEIGHT;
        _con.backgroundColor = [UIColor clearColor];
        [_con addTarget:self action:@selector(removeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _con;
}
- (NSMutableArray *)aryDatas{
    if (!_aryDatas) {
        _aryDatas = [NSMutableArray new];
    }
    return _aryDatas;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT) style:UITableViewStyleGrouped];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SwitchArchiveCell class] forCellReuseIdentifier:@"SwitchArchiveCell"];
        _tableView.top = NAVIGATIONBAR_HEIGHT;
    }
    return _tableView;
}
- (UIView *)BG{
    if (!_BG) {
        _BG = [UIView new];
        _BG.backgroundColor = [UIColor whiteColor];
        _BG.top = NAVIGATIONBAR_HEIGHT;
        _BG.width = SCREEN_WIDTH;
    }
    return _BG;
}
- (UIView *)blackBG{
    if (!_blackBG) {
        _blackBG = [UIView new];
        _blackBG.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _blackBG.top = NAVIGATIONBAR_HEIGHT;
        _blackBG.width = SCREEN_WIDTH;
        _blackBG.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT;
    }
    return _blackBG;
}

#pragma mark 刷新view
- (void)resetViewWithArys:(NSArray *)ary{
    self.aryDatas = [ary mutableCopy];
    [self removeSubViewWithTag:TAG_LINE];//移除线
    CGFloat cellHeight = [SwitchArchiveCell fetchHeight:@" "];

    //重置视图坐标
    self.BG.height = MIN(cellHeight*ary.count, SCREEN_HEIGHT/3.0*2.0);
    [self.BG removeCorner];
    [self.BG addRoundCorner:UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
    
    self.tableView.height = self.BG.height;

    self.con.top = self.BG.bottom;
    [self.tableView reloadData];
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;//默认宽度
        self.height = SCREEN_HEIGHT;//默认宽度
        [self addSubView];//添加子视图
    }
    return self;
}
//添加subview
- (void)addSubView{
    //初始化页面
    [self addSubview:self.blackBG];
    [self addSubview:self.BG];
    [self addSubview:self.tableView];
    [self addSubview:self.con];
    [self addSubview:self.conTop];

}
#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.aryDatas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SwitchArchiveCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchArchiveCell" forIndexPath:indexPath];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SwitchArchiveCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.blockSelected) {
        self.blockSelected((int)indexPath.row);
    }
    [self removeFromSuperview];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(void)removeClick{
    if (self.blockCancel) {
        self.blockCancel();
    }
    [self removeFromSuperview];
}
@end



@implementation SwitchArchiveCell
#pragma mark 懒加载
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
    }
    return _name;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.name];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(NSString *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
        
    [self.name fitTitle:UnPackStr(model) variable:SCREEN_WIDTH - W(90)];
    self.name.leftTop = XY(W(45),W(19));

    //设置总高度
    self.height = self.name.bottom + self.name.top;
    [self.contentView addLineFrame:CGRectMake(self.name.left, self.height -1, SCREEN_WIDTH - self.name.left*2, 1)];
}

@end
