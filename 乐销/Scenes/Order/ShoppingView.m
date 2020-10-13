//
//  ShoppingView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/9.
//Copyright © 2020 ping. All rights reserved.
//

#import "ShoppingView.h"

@interface ShoppingShopView ()<UIScrollViewDelegate>

@end

@implementation ShoppingShopView
#pragma mark 懒加载
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.showsVerticalScrollIndicator = false;
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = true;
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (SLPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[SLPageControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, W(26)) ];
        _pageControl.currentPage = 0;
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"FFA900" alpha:0.2];
        _pageControl.currentPageIndicatorTintColor = COLOR_ORANGE;

    }
    return _pageControl;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.height = W(223);

        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    self.scrollView.widthHeight = self.widthHeight;
    self.pageControl.bottom = self.height;
}


#pragma mark 刷新view
- (void)resetViewWithModels:(NSArray *)ary{
    
    [self.scrollView removeAllSubViews];
    CGFloat left = 0;
    for (int i = 0; i < ary.count; i++) {
        ShopItemView * shopView = [ShopItemView new];
        [shopView resetViewWithModels:@[@"",@"",@""]];
        shopView.left = left;
        left = shopView.right;
        [self.scrollView addSubview:shopView];
    }
    int counts = ary.count;
    
    self.pageControl.numberOfPages = counts;
    self.pageControl.currentPage = 0;
    self.pageControl.hidden = counts <= 1;

    self.scrollView.contentSize = CGSizeMake(counts *self.scrollView.width, 0);
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark sc代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self reconfigPageControl];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (decelerate ==NO) {
        [self reconfigPageControl];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self reconfigPageControl];
}
- (void)reconfigPageControl;
{
     int current = self.scrollView.contentOffset.x/self.scrollView.width;
    self.pageControl.currentPage = current;
}
@end

@implementation ShopItemView
#pragma mark 懒加载
- (UIImageView *)logo{
    if (_logo == nil) {
        _logo = [UIImageView new];
        _logo.image = [UIImage imageNamed:IMAGE_BIG_DEFAULT];
        _logo.widthHeight = XY(W(45),W(45));
        _logo.contentMode = UIViewContentModeScaleAspectFill;
        _logo.clipsToBounds = true;
        [_logo addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];

    }
    return _logo;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _name.numberOfLines = 1;
        _name.lineSpace = 0;
    }
    return _name;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_333;
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _time.numberOfLines = 1;
        _time.lineSpace = 0;
    }
    return _time;
}
-(UIButton *)enter{
    if (_enter == nil) {
        _enter = [UIButton buttonWithType:UIButtonTypeCustom];
        _enter.tag = 1;
        [_enter addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _enter.backgroundColor = [UIColor clearColor];
        [_enter setBackgroundImage:[UIImage imageNamed:@"shopping_enter"] forState:UIControlStateNormal];
        _enter.widthHeight = XY(W(65),W(25));
    }
    return _enter;
}

- (UIImageView *)bg{
    if (_bg == nil) {
        _bg = [UIImageView new];
        _bg.image = [UIImage imageNamed:@"shopping_top_bgbg"];
        _bg.widthHeight = XY(W(375),W(233));
    }
    return _bg;
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
    [self addSubview:self.bg];
    [self addSubview:self.logo];
    [self addSubview:self.name];
    [self addSubview:self.time];
    [self addSubview:self.enter];
    
}

#pragma mark 刷新view
- (void)resetViewWithModels:(NSArray *)ary{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    //    [self.logo sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    self.logo.image = [UIImage imageNamed:@"temp_银座"];
    self.logo.leftTop = XY(W(30),W(30));
    
    self.enter.rightTop = XY(SCREEN_WIDTH - W(30),W(40));
    
    [self.name fitTitle:@"中百超市（梨园街店）" variable:self.enter.left - self.logo.right - W(20)];
    self.name.leftTop = XY(self.logo.right+ W(10),self.logo.top+W(3));
    [self.time fitTitle:@"营业时间：08:00-22:00" variable:self.enter.left - self.logo.right - W(20)];
    self.time.leftBottom = XY(self.logo.right+ W(10),self.logo.bottom-W(4));
    
    
    //设置总高度
    self.height = W(223);
    
    CGFloat left = W(15);
    for (int i = 0; i < ary.count; i++) {
        ShoppingProductItemView * itemView = [ShoppingProductItemView new];
        itemView.tag = TAG_LINE;
        if (i%3==0) {
            left += W(15);
        }
        itemView.leftTop = XY(left, W(95));
        left = itemView.right + W(15);
        [self addSubview:itemView];
    }
    
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    [GB_Nav pushVCName:@"ShopDetailVC" animated:true];
    
}

@end

@implementation ShoppingProductItemView
#pragma mark 懒加载
- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [UIImageView new];
        _icon.image = [UIImage imageNamed:IMAGE_BIG_DEFAULT];
        _icon.backgroundColor = [UIColor clearColor];
        _icon.widthHeight = XY(W(95),W(95));
        {
            UIImageView * ivShadow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopping_top_shadow"]];
            ivShadow.backgroundColor = [UIColor clearColor];
            ivShadow.widthHeight = XY(W(95), W(27));
            ivShadow.leftBottom = XY(0, W(95));
            [_icon addSubview:ivShadow];
        }
        [_icon addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];
        
        
    }
    return _icon;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = [UIColor whiteColor];
        _price.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _price.numberOfLines = 1;
        _price.lineSpace = 0;
    }
    return _price;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.icon];
    [self addSubview:self.price];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
//    [self.icon sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
    self.icon.image = [UIImage imageNamed:@"temp_computer"];
    [self.price fitTitle:@"￥99" variable:0];
    self.price.leftBottom = XY(W(6),self.icon.bottom-W(6));
    
    //设置总高度
    self.widthHeight = self.icon.widthHeight;
}

@end



@implementation ShoppingShopCell
#pragma mark 懒加载
- (UIImageView *)logo{
    if (_logo == nil) {
        _logo = [UIImageView new];
        _logo.image = [UIImage imageNamed:IMAGE_BIG_DEFAULT];
        _logo.widthHeight = XY(W(65),W(65));
        _logo.contentMode = UIViewContentModeScaleAspectFill;
        _logo.clipsToBounds = true;
        [_logo addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];

    }
    return _logo;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _name.numberOfLines = 1;
        _name.lineSpace = 0;
    }
    return _name;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_666;
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _time.numberOfLines = 1;
        _time.lineSpace = 0;
    }
    return _time;
}
- (UIImageView *)star{
    if (_star == nil) {
        _star = [UIImageView new];
        _star.image = [UIImage imageNamed:@"shope_star"];
        _star.widthHeight = XY(W(12),W(12));
    }
    return _star;
}
- (UILabel *)score{
    if (_score == nil) {
        _score = [UILabel new];
        _score.textColor = COLOR_ORANGE;
        _score.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _score.numberOfLines = 1;
        _score.lineSpace = 0;
    }
    return _score;
}
- (UILabel *)overturn{
    if (_overturn == nil) {
        _overturn = [UILabel new];
        _overturn.textColor = COLOR_666;
        _overturn.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _overturn.numberOfLines = 1;
        _overturn.lineSpace = 0;
    }
    return _overturn;
}
- (UILabel *)distance{
    if (_distance == nil) {
        _distance = [UILabel new];
        _distance.textColor = COLOR_666;
        _distance.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _distance.numberOfLines = 1;
        _distance.lineSpace = 0;
    }
    return _distance;
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
        [self.contentView addSubview:self.time];
        [self.contentView addSubview:self.star];
        [self.contentView addSubview:self.score];
        [self.contentView addSubview:self.overturn];
        [self.contentView addSubview:self.distance];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelShopList *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    [self.logo sd_setImageWithURL:[NSURL URLWithString:model.coverUrl] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_COMPANY_DEFAULT]];
//    self.logo.image = [UIImage imageNamed:@"temp_中百"];
    self.logo.leftTop = XY(W(20),W(15));
    

    [self.name fitTitle:UnPackStr(model.storeName) variable:SCREEN_WIDTH - self.logo.right - W(40)];
    self.name.leftTop = XY(self.logo.right + W(10),self.logo.top+W(2));
    [self.time fitTitle:[NSString stringWithFormat:@"营业时间：%@-%@",[self fetchTime:model.startTime],[self fetchTime:model.endTime]] variable:W(188)];
    self.time.leftCenterY = XY(self.logo.right + W(10),self.logo.centerY + W(1));
    
    self.star.leftBottom = XY(self.logo.right + W(10),self.logo.bottom-W(2));
    [self.score fitTitle:strDotF(model.storeScore) variable:0];
    self.score.leftCenterY = XY(self.star.right + W(6),self.star.centerY);
    [self.overturn fitTitle:[NSString stringWithFormat:@"月售%.f",model.monthAmount] variable:0];
    self.overturn.leftCenterY = XY(self.score.right + W(20),self.star.centerY);

    [self.distance fitTitle: [NSString stringWithFormat:@"距离%@",model.distanceShow] variable:0];
    self.distance.rightCenterY = XY(SCREEN_WIDTH - W(20),self.time.centerY);

    //设置总高度
    self.height = self.logo.bottom + W(15);
}
- (NSString *)fetchTime:(double)time{
    time = strDotF(time).length >=8?time/1000.0:time;
    double hour = time/3600.0;
    double minute = (time - hour*3600.0)/60.0;
    return [NSString stringWithFormat:@"%02.lf:%02.lf",hour,minute];
}
@end
