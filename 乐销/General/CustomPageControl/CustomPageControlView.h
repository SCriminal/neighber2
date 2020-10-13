//
//  CustomPageControlView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/6/17.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPageControlView : UIView

#pragma mark 刷新view
- (void)resetViewWithNum:(int)num;
- (void)setIndex:(int)index;

@end
