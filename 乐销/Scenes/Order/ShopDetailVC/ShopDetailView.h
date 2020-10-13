//
//  ShopDetailView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/12.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopDetailTopView : UIView
@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UIImageView *star;
@property (strong, nonatomic) UILabel *score;
@property (strong, nonatomic) UILabel *overturn;
@property (strong, nonatomic) UILabel *phone;
@property (strong, nonatomic) UILabel *address;
@property (strong, nonatomic) UILabel *addressTitle;
@property (strong, nonatomic) UILabel *navigation;
@property (strong, nonatomic) UIImageView *navIV;
@property (nonatomic, strong) ModelShopList *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelShopList *)model;

@end

@interface SearchDetailSearchView : UIView<UITextFieldDelegate>
//属性
@property (strong, nonatomic) UIButton *btnSearch;
@property (strong, nonatomic) UITextField *tfSearch;
@property (strong, nonatomic) UIView *viewBG;
@property (nonatomic, strong) void (^blockSearch)(NSString *);
@property (nonatomic, strong) UIControl *backBtn;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end



