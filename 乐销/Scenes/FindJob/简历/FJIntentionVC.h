//
//  FJIntentionVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/13.
//Copyright © 2020 ping. All rights reserved.
//

#import "FJEducationVC.h"

@interface FJIntentionVC : FJEducationVC

@end


@interface SelectExpactJobView : UIView
@property (nonatomic, strong) void (^blockSelect)(NSString *,NSString *);

@property (strong, nonatomic) NSArray *aryDatas0;
@property (strong, nonatomic) NSArray *aryDatas1;
@property (strong, nonatomic) NSArray *aryDatas2;
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component;
@end
