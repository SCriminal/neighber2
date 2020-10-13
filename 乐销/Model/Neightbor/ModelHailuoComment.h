//
//  ModelHailuoComment.h
//
//  Created by 林栋 隋 on 2020/8/18
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelHailuoComment : NSObject

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *serveName;
@property (nonatomic, assign) double start;
@property (nonatomic, assign) double createTime;
@property (nonatomic, strong) NSArray *photo;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *icon;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
