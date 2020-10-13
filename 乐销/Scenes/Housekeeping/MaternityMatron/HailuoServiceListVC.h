//
//  MaternityMatronListVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"
/* 2    月嫂服务7    保姆服务 12    搬家搬运 14    综合维修 25    育婴服务 28    钟点工 30    衣物清洗 32    保洁服务 39    空气检测 44    助老服务 46    心理辅导 53    装修装饰 63    花卉养殖 66    涉外服务 70    保健按摩 73    陪护服务 76    其他 79    家电清洗 89    养老机构 */
typedef NS_ENUM(NSUInteger, ENUM_HAILUO_SERVICE_TYPE) {
    ENUM_HAILUO_SERVICE_MATERNITYMATRON = 2,
    ENUM_HAILUO_SERVICE_BABYSITTER = 7,
    ENUM_HAILUO_SERVICE_MOVEHOUSE = 12,
    ENUM_HAILUO_SERVICE_MAINTAIN = 14,
    ENUM_HAILUO_SERVICE_INFANTCARE = 25,
    ENUM_HAILUO_SERVICE_HOURLYEMPLOYEE = 28,
    ENUM_HAILUO_SERVICE_CLOTHESCLEAN = 30,
    ENUM_HAILUO_SERVICE_CLEANKEEPING = 32,
    ENUM_HAILUO_SERVICE_ARIDETECTION = 39,
    ENUM_HAILUO_SERVICE_OLDHELP = 44,
    ENUM_HAILUO_SERVICE_PSYCHOLOGY = 46,
    ENUM_HAILUO_SERVICE_DECORATE = 53,
    ENUM_HAILUO_SERVICE_FLOWER = 63,
    ENUM_HAILUO_SERVICE_FOREIGN = 66,
    ENUM_HAILUO_SERVICE_MASSAGE = 70,
    ENUM_HAILUO_SERVICE_ACCOMPANY = 73,
    ENUM_HAILUO_SERVICE_OTHER = 76,
    ENUM_HAILUO_SERVICE_APPLIANCECLEAN = 79,
    ENUM_HAILUO_SERVICE_OLDPEOPLE = 89,

};
@interface HailuoServiceListVC : BaseTableVC
@property (nonatomic, assign) ENUM_HAILUO_SERVICE_TYPE type;
@property (nonatomic, strong) NSString *navTitle;
@property (nonatomic, assign) double companyID;
@end
