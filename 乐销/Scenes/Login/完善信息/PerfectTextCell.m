//
//  PerfectTextCell.m
//中车运
//
//  Created by 隋林栋 on 2018/10/24.
//Copyright © 2018年 ping. All rights reserved.
//

#import "PerfectTextCell.h"
#import "BaseTableVC+Authority.h"
@interface PerfectTextCell ()

@end

@implementation PerfectTextCell

#pragma mark 懒加载
- (UIView *)whiteBG{
    if (_whiteBG == nil) {
        _whiteBG = [UIView new];
        _whiteBG.backgroundColor = [UIColor whiteColor];
    }
    return _whiteBG;
}
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _title.numberOfLines = 0;
        _title.lineSpace = 0;
    }
    return _title;
}
- (UITextField *)textField{
    if (_textField == nil) {
        _textField = [UITextField new];
        _textField.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.textColor = COLOR_333;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.backgroundColor = [UIColor clearColor];
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFileAction:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _textField;
}
- (UILabel *)essential{
    if (_essential == nil) {
        _essential = [UILabel new];
        _essential.textColor = [UIColor redColor];
        _essential.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        [_essential fitTitle:@"*" variable:0];
    }
    return _essential;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = COLOR_GRAY;
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.whiteBG];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.textField];
        [self.contentView addTarget:self action:@selector(cellClick)];
        self.contentView.clipsToBounds = true;
        [self.contentView addSubview:self.essential];

    }
    return self;
}
#pragma mark 刷新cell

- (void)resetCellWithModel:(ModelBaseData *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //设置总高度
    self.height = HEIGHT_TEXT_CELL;
    
    [self.title fitTitle:model.string variable:0];
    self.title.leftCenterY = XY(MAX(model.stringInterval, W(35)),self.height/2.0);
    self.title.textColor = self.model.isChangeInvalid?COLOR_999:COLOR_333;

    self.essential.leftCenterY = XY(self.title.right+W(2), self.title.centerY);
    self.essential.hidden = !model.isRequired;
    
    CGFloat leftInterval = self.leftInterval?self.leftInterval:(W(127));
    
    self.textField.widthHeight = XY(SCREEN_WIDTH - leftInterval - W(35), [GlobalMethod fetchHeightFromFont:self.textField.font.pointSize]);
    self.textField.leftCenterY = XY(leftInterval, self.title.centerY);
    self.textField.text = model.subString;
    self.textField.textColor = model.isChangeInvalid?COLOR_999:COLOR_333;
    self.textField.userInteractionEnabled = !model.isChangeInvalid;

    {
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = COLOR_999;
        attrs[NSFontAttributeName] = self.textField.font;
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc]initWithString:self.model.isChangeInvalid?@"不可修改":UnPackStr(model.placeHolderString) attributes:attrs];
        self.textField.attributedPlaceholder = placeHolder;
    }
    if (!model.hideState) {
        [self.contentView addLineFrame:CGRectMake(W(35), self.height -1, SCREEN_WIDTH - W(70), 1)];
    }
    self.whiteBG.widthHeight = XY(W(345), self.height);
    self.whiteBG.centerXTop = XY(SCREEN_WIDTH/2.0, 0);
    [self.whiteBG removeCorner];
    switch (self.model.locationType) {
        case ENUM_CELL_LOCATION_TOP:
            [self.whiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
            break;
        case ENUM_CELL_LOCATION_BOTTOM:
            [self.whiteBG addRoundCorner:UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
            break;
        default:
            break;
    }
    

}

#pragma mark cell click
- (void)cellClick{
    if (self.model.isChangeInvalid) {
        [GlobalMethod showAlert:@"不可修改"];
        return;
    }
    if (self.textField.userInteractionEnabled ) {
        [self.textField becomeFirstResponder];
    }
}
#pragma mark textfild change
- (void)textFileAction:(UITextField *)textField {
    self.model.subString = textField.text;
}

#pragma mark tf 代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.model.string isEqualToString:@"车牌号码"]) {
        textField.text = textField.text.uppercaseString;
        self.model.subString = textField.text;
    }
}
@end



@implementation PerfectEmptyCell

- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _title.textColor = COLOR_999;
        _title.numberOfLines = 0;
        _title.lineSpace = 0;
    }
    return _title;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.title];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    [self.title fitTitle:UnPackStr(model.string) variable:0];
    //设置总高度
    if (isStr(model.string)) {
        self.height = self.title.height + W(30);
        self.title.leftCenterY = XY(W(25), self.height/2.0);
    }else{
        self.height = W(13);
    }

 
}

@end
