//
//  IntegralCenterView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegralCenterView : UIView
@property (strong, nonatomic) UIImageView *BG;
@property (strong, nonatomic) UILabel *scoreNum;
@property (strong, nonatomic) UILabel *score;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UIButton *btnRecord;
@property (nonatomic, strong) void (^blockBillClick)(void);

#pragma mark 刷新view
- (void)resetViewWithModel:(int)score;

@end
