//
//  ModelAuthentication.h
//
//  Created by 林栋 隋 on 2020/4/23
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAuthentication : NSObject

@property (nonatomic, assign) double status;
@property (nonatomic, strong) NSString *idPortrait;
@property (nonatomic, strong) NSString *idEmblem;
@property (nonatomic, strong) NSString *internalBaseClassDescription;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSString *statusShow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
