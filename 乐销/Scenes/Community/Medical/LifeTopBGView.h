//
//  LifeTopBGView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/2.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LifeTopBGView : UIView
@property (nonatomic, strong) UIImageView *BG;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
