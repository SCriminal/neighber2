//
//  LifeTopBGView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/2.
//Copyright © 2020 ping. All rights reserved.
//

#import "LifeTopBGView.h"

@interface LifeTopBGView ()
@property (nonatomic, strong) BaseNavView *nav;
@property (strong, nonatomic) UIView *whiteBG;

@end

@implementation LifeTopBGView

- (BaseNavView *)nav{
    if (!_nav) {
        _nav = [BaseNavView initNavBackTitle:@"" rightView:nil];
        _nav.backgroundColor = [UIColor clearColor];
    }
    return _nav;
}
- (UIImageView *)BG{
    if (_BG == nil) {
        _BG = [UIImageView new];
        _BG.image = [UIImage imageNamed:@"hospital_bg"];
        
        _BG.contentMode = UIViewContentModeScaleAspectFill;
        _BG.clipsToBounds = true;
    }
    return _BG;
}
- (UIView *)whiteBG{
    if (_whiteBG == nil) {
        _whiteBG = [UIView new];
        _whiteBG.backgroundColor = [UIColor whiteColor];
        _whiteBG.widthHeight = XY(SCREEN_WIDTH,30);
        [_whiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:15 lineWidth:0 lineColor:[UIColor clearColor]];
        
        
    }
    return _whiteBG;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_GRAY;
        self.width = SCREEN_WIDTH;
        self.height = W(135)+iphoneXTopInterval;
        self.clipsToBounds = true;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.BG];
    [self addSubview:self.whiteBG];
    [self addSubview:self.nav];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.BG.widthHeight = XY(SCREEN_WIDTH, self.height);
    self.whiteBG.top = self.height- 15;
}

@end
