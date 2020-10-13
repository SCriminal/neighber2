//
//  EditFJInfoVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface EditFJInfoVC : BaseTableVC
@property (nonatomic, strong) ModelResumeDetail *modelResumeDetail;

@end


@interface SelectExpactProfessionView : UIView
@property (nonatomic, strong) void (^blockSelect)(ModelUserAuthority *);

@property (strong, nonatomic) NSArray *aryDatas0;
@property (strong, nonatomic) NSArray *aryDatas1;

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component;
@end
