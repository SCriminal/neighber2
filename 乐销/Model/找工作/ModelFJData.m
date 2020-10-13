//
//  ModelFJData.m
//
//  Created by 林栋 隋 on 2020/9/15
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelFJData.h"


NSString *const kModelFJDataId = @"id";
NSString *const kModelFJDataCategoryname = @"categoryname";


@interface ModelFJData ()
@end

@implementation ModelFJData

@synthesize iDProperty = _iDProperty;
@synthesize categoryname = _categoryname;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.iDProperty = [dict stringValueForKey:kModelFJDataId];
        self.categoryname = [dict stringValueForKey:kModelFJDataCategoryname];
        if (!isStr(self.categoryname)) {
            self.categoryname = [dict stringValueForKey:@"tag"];
        }
        if (!isStr(self.iDProperty)) {
            double num = [dict doubleValueForKey:kModelFJDataId];
            if (num) {
                self.iDProperty = NSNumber.dou(num).stringValue;
            }
        }
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.iDProperty forKey:kModelFJDataId];
    [mutableDict setValue:self.categoryname forKey:kModelFJDataCategoryname];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

+ (NSMutableArray *)transferDic:(NSDictionary *)dic{
    NSMutableArray * aryReturn = [NSMutableArray array];
    if ([dic isKindOfClass:NSDictionary.class]) {
        for (NSString * key in dic.allKeys) {
               NSString * value = [dic objectForKey:key];;
               if ([value isKindOfClass:NSString.class]) {
                   ModelFJData * item = [ModelFJData new];
                   item.iDProperty = key;
                   item.categoryname = value;
                   [aryReturn addObject:item];
               }
           }
    }else if([dic isKindOfClass:NSArray.class]){
       aryReturn = [GlobalMethod exchangeDic:dic toAryWithModelName:@"ModelFJData"];
    }
   
    return aryReturn;
}

+ (NSMutableArray *)transferDicAry:(NSArray *)ary{
    NSMutableArray * aryReturn = [NSMutableArray array];
    for (NSDictionary * dic in ary) {
        for (NSString * key in dic.allKeys) {
               NSString * value = [dic objectForKey:key];;
               if ([value isKindOfClass:NSString.class]) {
                   ModelFJData * item = [ModelFJData new];
                   item.iDProperty = key;
                   item.categoryname = value;
                   [aryReturn addObject:item];
               }else if ([value isKindOfClass:NSDictionary.class]){
                   NSDictionary * subDic = (NSDictionary *)value;
                     ModelFJData * item = [ModelFJData modelObjectWithDictionary:subDic];
                   [aryReturn addObject:item];
               }
           }
    }
   
    return aryReturn;
}
@end
