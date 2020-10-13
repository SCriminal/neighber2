//
//  FindJobMainView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/27.
//Copyright © 2020 ping. All rights reserved.
//

#import "FindJobMainView.h"
@interface FindJobNewsView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView * scView;
@property (nonatomic, strong) UILabel * notice;

@end

@implementation FindJobNewsView

#pragma mark lazy init
- (UILabel *)notice{
    if (!_notice) {
        _notice = ^(){
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(10) weight:UIFontWeightRegular];
            l.textColor = [UIColor colorWithHexString:@"#FF9300"];
            l.backgroundColor = [UIColor colorWithHexString:@"#FFF6E3"];
            [l fitTitle:@"快讯" variable:0];
            l.textAlignment = NSTextAlignmentCenter;
            l.widthHeight = XY(W(30), W(16));
            [l addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:2 lineWidth:0.5 lineColor:[UIColor colorWithHexString:@"#FF9300"]];
            l.left = W(15);
            return l;
        }();
        
    }
    return _notice;
}
- (NSMutableArray *)aryDatas{
    if (!_aryDatas) {
        _aryDatas = [NSMutableArray new];
    }
    return _aryDatas;
}
- (UIScrollView *)scView{
    if (!_scView) {
        //添加sc
        _scView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, W(280), [UIFont systemFontOfSize:F(12)].lineHeight)];
        _scView.delegate = self;
        _scView.pagingEnabled = YES;
        _scView.showsHorizontalScrollIndicator = NO;
        _scView.showsVerticalScrollIndicator = NO;
        _scView.backgroundColor = [UIColor clearColor];
        _scView.bounces = NO;
        _scView.contentSize = CGSizeMake(0, CGRectGetHeight(_scView.frame)*3);
        _scView.userInteractionEnabled = false;
    }
    return _scView;
}

#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSuview];
    }
    return self;
}
- (void)addSuview{
    self.backgroundColor = [UIColor whiteColor];
    self.isClickValid = true;
    [self addTarget:self action:@selector(click)];
    //add subview
    UIView * view = [UIView new];
       view.backgroundColor = [UIColor colorWithHexString:@"#F7F8F9"];
       view.widthHeight = XY(W(345), W(25));
       view.centerXTop = XY(SCREEN_WIDTH/2.0, 0);
       [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];
       [self addSubview:view];
    [self addSubview:self.notice];
    [self addSubview:self.scView];
    self.notice.leftCenterY = XY(W(25), view.height/2.0);
    self.scView.leftCenterY = XY(W(63), view.height/2.0);
    self.widthHeight = XY(SCREEN_WIDTH, view.height);
    
}

#pragma mark resetView
- (void)resetWithAry:(NSArray *)aryDatas{
    if (!isAry(aryDatas)) {
        return;
    }
    self.scView.scrollEnabled = aryDatas.count>1;
    self.aryDatas = aryDatas.mutableCopy;
    //reset sc
    [self resetImageAnimated:NO];
}

#pragma mark 布置图片
- (void)resetImageAnimated:(BOOL)animated{
    if (!isAry(self.aryDatas))return;
    [self.scView removeAllSubViews];
    self.numNow = self.numNow<0?self.numNow+(int)self.aryDatas.count:self.numNow;
    int numTmp =self.numNow-1<0?(int)self.aryDatas.count-1+self.numNow:self.numNow-1;
    int numFirst = numTmp%self.aryDatas.count;
    int numSec = self.numNow%self.aryDatas.count;
    int numThird = (self.numNow+1)%self.aryDatas.count;
    
    [self addLabel:numFirst index:0];
    [self addLabel:numSec index:1];
    [self addLabel:numThird index:2];
    [self.scView setContentOffset:CGPointMake(0, CGRectGetHeight(self.scView.frame)) animated:animated];
   
}

- (void)addLabel:(NSUInteger)num index:(int)index{
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    l.textColor = COLOR_333;
    l.backgroundColor = [UIColor clearColor];
    l.numberOfLines = 1;
    if (self.aryDatas.count<=num) {
        return;
    }
    l.text = UnPackStr(self.aryDatas[num]);
    l.widthHeight = self.scView.widthHeight;
    l.top = index*CGRectGetHeight(self.scView.frame);
    [self.scView addSubview:l];
}


#pragma mark sc代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self countNum];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (decelerate ==NO) {
        [self countNum];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.numNow++;
    [self resetImageAnimated:NO];
}

#pragma mark 重新计算
- (void)countNum{
    _numTime = 1;
    if (self.scView.contentOffset.y<=5) {
        self.numNow--;
        [self resetImageAnimated:NO];
    }if (self.scView.contentOffset.y>=(CGRectGetHeight(self.scView.frame)*2-5)) {
        self.numNow++;
        [self resetImageAnimated:NO];
    }
}

#pragma mark image click
- (void)click{
    if (!isAry(self.aryDatas)) return;
    if (!self.isClickValid) return;
        int numSec = self.numNow%self.aryDatas.count;
        if (self.blockClick) {
            self.blockClick(numSec);
        }
}

#pragma mark 定时器相关
- (void)timerStart{
    //开启定时器
    if (_timer == nil) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    }
    _numTime = 0;
}

- (void)timerRun{
    //每秒的动作
    if (_numTime >0) {
        //有人触碰 时间重置
        _numTime--;
        return;
    }
    if (!self.scView.scrollEnabled) {
        return;
    }
    [self.scView setContentOffset:CGPointMake(0, CGRectGetHeight(self.scView.frame)*2) animated:YES];
}

- (void)timerStop{
    //停止定时器
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)dealloc{
    [self timerStop];
}

@end



@implementation FindJobNewsCell
#pragma mark 懒加载
- (UILabel *)jobName{
    if (_jobName == nil) {
        _jobName = [UILabel new];
        _jobName.textColor = COLOR_333;
        _jobName.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _jobName;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = COLOR_ORANGE;
        _price.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _price;
}
- (UILabel *)address{
    if (_address == nil) {
        _address = [UILabel new];
        _address.textColor = COLOR_666;
        _address.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _address;
}
- (UIImageView *)logo{
    if (_logo == nil) {
        _logo = [UIImageView new];
        _logo.widthHeight = XY(W(15),W(15));
        [_logo addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
    }
    return _logo;
}

- (UILabel *)companyName{
    if (_companyName == nil) {
        _companyName = [UILabel new];
        _companyName.textColor = COLOR_999;
        _companyName.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _companyName;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.jobName];
    [self.contentView addSubview:self.price];
    [self.contentView addSubview:self.address];
    [self.contentView addSubview:self.logo];
    [self.contentView addSubview:self.companyName];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelFJJobList *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.jobName fitTitle:UnPackStr(model.jobsName) variable:W(250)];
    self.jobName.leftTop = XY(W(15),W(20));
    [self.price fitTitle:UnPackStr(model.wageCn) variable:0];
    self.price.rightCenterY = XY(SCREEN_WIDTH - W(15),self.jobName.centerY);
    [self.address fitTitle:[NSString stringWithFormat:@"%@|%@|%@",UnPackStr(model.districtCn),UnPackStr(model.experienceCn),UnPackStr(model.educationCn)] variable:SCREEN_WIDTH - W(30)];
    self.address.leftTop = XY(W(15),self.price.bottom+W(13));

    [self.logo sd_setImageWithURL:[NSURL URLWithString:UnPackStr(model.logo)] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_COMPANY_DEFAULT]];
    self.logo.leftTop = XY(W(15),self.address.bottom+W(15));
    [self.companyName fitTitle:[NSString stringWithFormat:@"%@ %@",UnPackStr(model.companyname),UnPackStr(model.scaleCn)] variable:W(300)];
    self.companyName.leftCenterY = XY(self.logo.right + W(7),self.logo.centerY);

    //设置总高度
    self.height = self.logo.bottom + W(13);
    [self.contentView addLineFrame:CGRectMake(W(15), self.height -1, SCREEN_WIDTH - W(30), 1)];
}

@end
