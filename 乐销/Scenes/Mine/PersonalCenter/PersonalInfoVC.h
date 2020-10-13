//
//  PersonalInfoVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/26.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface PersonalInfoVC : BaseTableVC
@end


@interface PersonalInfoView : UIView
//属性
@property (strong, nonatomic) UIImageView *head;
@property (strong, nonatomic) UILabel *authority;
@property (strong, nonatomic) UILabel *archive;
@property (strong, nonatomic) UILabel *memeber;
- (void)resetHeaderView;

- (void)resetAuthTitle:(NSString *)title ;

- (void)resetArchiveTitle:(NSString *)title ;

- (void)resetMemeberTitle:(NSString *)title ;
@end
