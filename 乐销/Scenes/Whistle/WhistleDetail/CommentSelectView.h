//
//  CommentSelectView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/12/16.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentSelectView : UIView
@property (nonatomic, assign) int indexSelected;
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
