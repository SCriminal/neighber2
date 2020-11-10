//
//  EhomeBindAlertView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/11/9.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EhomeBindAlertView : UIView

@property (strong, nonatomic) UIView *viewBG;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *close;
@property (strong, nonatomic) UIButton *btn;
@property (strong, nonatomic) UIButton *btnClose;
@property (nonatomic, strong) void (^blockConfirmClick)(ModelEhomeHomeItem *);
@property (nonatomic, strong) ModelEhomeHomeItem *model;
- (void)resetViewWithModel:(ModelEhomeHomeItem *)model;
@end
