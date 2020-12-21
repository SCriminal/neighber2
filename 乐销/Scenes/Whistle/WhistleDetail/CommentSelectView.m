//
//  CommentSelectView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/12/16.
//Copyright © 2020 ping. All rights reserved.
//

#import "CommentSelectView.h"

@interface CommentSelectView ()

@end

@implementation CommentSelectView

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeAllSubViews];
    self.height = W(20);
    CGFloat left = W(30);
    NSArray * ary = @[@"不满意",@"基本满意",@"满意"];
    for (int i = 0; i<ary.count; i++) {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"select_default"];
        iv.highlightedImage = [UIImage imageNamed:@"select_highlighted"];
        iv.tag = i+100;
        iv.widthHeight = XY(W(15),W(15));
        iv.leftCenterY = XY(left,self.height/2.0);
        [self addSubview:iv];
        
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        l.textColor = COLOR_999;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:ary[i] variable:SCREEN_WIDTH - W(30)];
        l.leftCenterY = XY(iv.right + W(5), self.height/2.0);
        [self addSubview:l];
        UIView * con = [self addControlFrame:CGRectMake(left, 0, l.right +W(6) - left, self.height) target:self action:@selector(click:)];
        con.tag = i;
        
        left = l.right + W(12);
        
        if (i == 2) {
            [self click:(UIControl *)con];
        }
    }
    
}


#pragma mark 点击事件
- (void)click:(UIControl *)sender{
    for (int i = 0; i<3; i++) {
        UIImageView * iv = [self viewWithTag:100+i];
        if ([iv isKindOfClass:[UIImageView class]]) {
            iv.highlighted = false;
        }
    }
    UIImageView * iv = [self viewWithTag:100+sender.tag];
    if ([iv isKindOfClass:[UIImageView class]]) {
        iv.highlighted = true;
    }
    self.indexSelected = sender.tag;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        self.indexSelected = -1;
        [self addSubView];//添加子视图
    }
    return self;
}
//添加subview
- (void)addSubView{
    //初始化页面
    [self resetViewWithModel:nil];
}

@end
