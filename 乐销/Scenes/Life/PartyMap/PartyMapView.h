//
//  PartyMapView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/6/30.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartyMapSearchView : UIView<UITextFieldDelegate>
//属性
@property (strong, nonatomic) UIButton *btnSearch;
@property (strong, nonatomic) UITextField *tfSearch;
@property (strong, nonatomic) UIView *viewBG;
@property (nonatomic, strong) void (^blockSearch)(NSString *);
@property (nonatomic, strong) UIControl *backBtn;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end

@interface PartyMapJumpSearchView : UIView<UITextFieldDelegate>
//属性
@property (strong, nonatomic) UIButton *btnSearch;
@property (strong, nonatomic) UITextField *tfSearch;
@property (strong, nonatomic) UIView *viewBG;
@property (nonatomic, strong) UIControl *backBtn;
@property (nonatomic, strong) void (^blockSearchClick)(void);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end

@interface PartySearchListCell : UITableViewCell

@property (strong, nonatomic) UILabel *communityName;
@property (strong, nonatomic) UILabel *address;
@property (strong, nonatomic) UILabel *leader;
@property (strong, nonatomic) UILabel *people;
@property (strong, nonatomic) UILabel *phone;
@property (strong, nonatomic) UIImageView *iconPhone;
@property (strong, nonatomic) UILabel *labelPhone;
@property (strong, nonatomic) UIImageView *iconNav;
@property (strong, nonatomic) UILabel *labelNav;
@property (nonatomic, strong) ModelParty *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelParty *)model;

@end

@interface PartySearchBottomView : UIView

@property (strong, nonatomic) UILabel *communityName;
@property (strong, nonatomic) UILabel *brief;
@property (strong, nonatomic) UIImageView *iconClose;
@property (strong, nonatomic) UILabel *address;
@property (strong, nonatomic) UILabel *leader;
@property (strong, nonatomic) UILabel *people;
@property (strong, nonatomic) UILabel *phone;
@property (strong, nonatomic) UIImageView *iconPhone;
@property (strong, nonatomic) UILabel *labelPhone;
@property (strong, nonatomic) UIImageView *iconNav;
@property (strong, nonatomic) UILabel *labelNav;
@property (nonatomic, strong) ModelParty *model;

#pragma mark 刷新cell
- (void)resetViewWithModel:(ModelParty *)model;

@end
