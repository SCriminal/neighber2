//
//  CustomTabBar.m
//  DouBanProject
//
//  Created by wuli萍萍 on 16/5/6.
//  Copyright © 2016年 wuli萍萍. All rights reserved.
//

#import "CustomTabBar.h"

#define NUM_TAB 5
@implementation CustomTabBar

+(void)load{

}


- (void)layoutSubviews
   {
      [super layoutSubviews];
      
      //    CGFloat buttonW = SCREEN_WIDTH / NUM_TAB;// 每个的宽
      int index = 0;
      for (UIView *view in self.subviews) {
         // 获得这个类,并将类转换成字符串
         if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            switch (index) {
               case 0:
               view.centerX = W(42);
               break;
               case 1:
               view.centerX = W(110);
               break;
               case 2:
               view.centerX = SCREEN_WIDTH/2.0;
               break;
               case 3:
               view.centerX = SCREEN_WIDTH - W(110);
               break;
               case 4:
               view.centerX = SCREEN_WIDTH - W(42);
               break;
               default:
               break;
            }
            index ++;
         }
      }
      
   }
   
  
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
      UIView *view = [super hitTest:point withEvent:event];
      if (view == nil) {
         UIView * subView = [self viewWithTag:108];
         CGPoint p = [subView convertPoint:point fromView:self];
         if (CGRectContainsPoint(subView.bounds, p)) {
            view = subView;
         }
      }
      return view;
}
   
@end

