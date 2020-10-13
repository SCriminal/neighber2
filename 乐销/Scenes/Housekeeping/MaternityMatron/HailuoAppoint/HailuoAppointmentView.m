//
//  HailuoAppointmentView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/19.
//Copyright © 2020 ping. All rights reserved.
//

#import "HailuoAppointmentView.h"

@interface HailuoAppointmentView ()
@property (strong, nonatomic) UILabel *problemDescription;

@end

@implementation HailuoAppointmentView


- (PlaceHolderTextView *)textView{
    if (_textView == nil) {
        _textView = [PlaceHolderTextView new];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.delegate = self;
        _textView.textContainerInset = UIEdgeInsetsMake(-W(2), 0, 0, 0);
        [GlobalMethod setLabel:_textView.placeHolder widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_999 text:@"请填写其他需求"];
        [_textView setTextColor:COLOR_333];
    }
    return _textView;
}

- (UILabel *)problemDescription{
    if (_problemDescription == nil) {
        _problemDescription = [UILabel new];
        _problemDescription.textColor = COLOR_999;
        _problemDescription.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _problemDescription.numberOfLines = 1;
        _problemDescription.lineSpace = 0;
        [_problemDescription fitTitle:@"其他需求" variable:0];
        
    }
    return _problemDescription;
}

//添加subview
- (void)addSubView{
    [self addSubview:self.textView];
    [self addSubview:self.problemDescription];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.problemDescription.leftTop = XY(W(25),W(15));
    
    UIView *viewWhite = [UIView new];
    viewWhite.backgroundColor = [UIColor whiteColor];
    viewWhite.widthHeight = XY(W(345), W(100));
    viewWhite.centerXTop = XY(SCREEN_WIDTH/2.0, self.problemDescription.bottom + W(15));
    [viewWhite addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
    [self insertSubview:viewWhite belowSubview:self.textView];
    
    self.textView.widthHeight = XY(SCREEN_WIDTH - W(60), W(70));
    self.textView.centerXCenterY = viewWhite.centerXCenterY;
    
    self.height = self.textView.bottom + W(15);
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_GRAY;
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = true;
        [self addSubView];
    }
    return self;
}


@end
