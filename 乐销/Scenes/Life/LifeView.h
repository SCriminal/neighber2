//
//  LifeView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/10.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LifeFoldView : UIView
@property (nonatomic, strong) UIImageView *iconFold;
@property (nonatomic, strong) void (^blockClick)(void);
- (void)resetTitle:(NSString *)title;

@end
