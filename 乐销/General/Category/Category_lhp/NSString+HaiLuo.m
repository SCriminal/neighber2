//
//  NSString+HaiLuo.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/18.
//  Copyright © 2020 ping. All rights reserved.
//

#import "NSString+HaiLuo.h"

@implementation NSString (HaiLuo)
- (NSString *)hailuoImage{
    if ([self hasPrefix:@"http"]) {
        return self;
    }
    return [NSString stringWithFormat:@"%@%@",URL_HAILUO_IMAGE,self];
}

- (NSString *)findJobImage{
    if ([self hasPrefix:@"http"]) {
        return self;
    }
    return [NSString stringWithFormat:@"http://www.wfrcsc.com/data/upload/images/%@",self];
}
- (NSString *)findJobLogo{
    if ([self hasPrefix:@"http"]) {
        return self;
    }
    return [NSString stringWithFormat:@"http://www.wfrcsc.com/data/upload/company_logo/%@",self];
}
@end
