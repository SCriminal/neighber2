//
//  ModelModule.h
//
//  Created by 林栋 隋 on 2020/4/9
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelModule : NSObject

@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSString *moduleName;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) double goMode;
@property (nonatomic, strong) NSString *android;
@property (nonatomic, strong) NSString *ios;
@property (nonatomic, assign) double isLogin;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) BOOL isSelected;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
+ (void)jumpWithModule:(ModelModule *)model;
@end
