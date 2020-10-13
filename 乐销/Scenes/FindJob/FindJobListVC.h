//
//  FindJobListVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/31.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"
typedef NS_ENUM(NSUInteger, ENUM_FINDJOB_LIST_TYPE) {
    ENUM_FINDJOB_LIST_FIND = 1,
    ENUM_FINDJOB_LIST_NEARBY = 2,
    ENUM_FINDJOB_LIST_RECOMMEND = 3
};
@interface FindJobListVC : BaseTableVC
@property (nonatomic, assign) ENUM_FINDJOB_LIST_TYPE type;
@end
