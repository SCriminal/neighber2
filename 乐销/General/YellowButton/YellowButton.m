//
//  YellowButton.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "YellowButton.h"

@interface YellowButton ()
@property (nonatomic, strong) UIImageView *bg;

@end

@implementation YellowButton

- (UIImageView *)bg{
    if (!_bg) {
        _bg = [UIImageView new];
        _bg.image = [UIImage imageNamed:@"yellow_btn_bg"];
        _bg.contentMode = UIViewContentModeScaleAspectFill;
        _bg.clipsToBounds = true;
    }
    return _bg;
}
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = [UIColor whiteColor];
        _title.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _title.numberOfLines = 1;
        _title.lineSpace = 0;
    }
    return _title;
}
#pragma mark 刷新view
- (void)resetViewWithWidth:(CGFloat)width :(CGFloat)height :(NSString *)title{
    [self addSubview:self.bg];
    [self addSubview:self.title];
    self.widthHeight = XY(width, height);
    self.bg.widthHeight = self.widthHeight;
    [GlobalMethod setRoundView:self.bg color:[UIColor clearColor] numRound:self.bg.height/2.0 width:0];

    [self.title fitTitle:title variable:0];
    self.title.centerXCenterY = XY(self.width/2.0, self.height/2.0);
    
    [self addTarget:self action:@selector(click)];
    
    
}
- (void)resetWhiteViewWithWidth:(CGFloat)width :(CGFloat)height :(NSString *)title{
    self.backgroundColor = [UIColor colorWithHexString:@"#F5F6F7"];
    self.title.textColor = COLOR_999;
    self.title.font = [UIFont systemFontOfSize:F(16) weight:UIFontWeightMedium];
    self.bg.hidden = true;
    [self resetViewWithWidth:width :height :title];
    [GlobalMethod setRoundView:self color:[UIColor clearColor] numRound:self.height/2.0 width:0];

}
- (void)resetYellowHollowViewWithWidth:(CGFloat)width :(CGFloat)height :(NSString *)title{
    self.backgroundColor = [UIColor whiteColor];
    self.title.textColor = COLOR_ORANGE;
    self.title.font = [UIFont systemFontOfSize:F(16) weight:UIFontWeightMedium];
    self.bg.hidden = true;
    [self resetViewWithWidth:width :height :title];
    [GlobalMethod setRoundView:self color:COLOR_ORANGE numRound:self.height/2.0 width:1];

}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
    }
    return self;
}

#pragma mark click
- (void)click{
    if (self.blockClick) {
        self.blockClick();
    }
}

@end
