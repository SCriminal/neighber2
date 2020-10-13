//
//  ModelFJData.h
//
//  Created by 林栋 隋 on 2020/9/15
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelFJData : NSObject

@property (nonatomic, strong) NSString *iDProperty;
@property (nonatomic, strong) NSString *categoryname;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
+ (NSMutableArray *)transferDicAry:(NSArray *)ary;
+ (NSMutableArray *)transferDic:(NSDictionary *)dic;
@end
