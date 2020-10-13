//
//  SearchShopView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/9.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchShopNavView : UIView<UITextFieldDelegate>
//属性
@property (strong, nonatomic) UIButton *btnSearch;
@property (strong, nonatomic) UITextField *tfSearch;
@property (strong, nonatomic) UIView *viewBG;
@property (nonatomic, strong) void (^blockSearch)(NSString *);
@property (nonatomic, strong) UIControl *backBtn;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end


@interface SearchShopCategoryView : UIView

//属性
@property (strong, nonatomic) UIImageView *arrow;
@property (strong, nonatomic) UILabel *synthesize;
@property (strong, nonatomic) UILabel *sale;
@property (strong, nonatomic) UILabel *comprehensive;
@property (strong, nonatomic) UILabel *distance;
@property (strong, nonatomic) UILabel *score;
@property (nonatomic, assign) int indexSelect;
@property (nonatomic, strong) void (^blockSelect)(int);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
