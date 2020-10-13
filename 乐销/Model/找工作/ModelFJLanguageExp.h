//
//  ModelFJLanguageExp.h
//
//  Created by 林栋 隋 on 2020/9/16
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelFJLanguageExp : NSObject

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *iDProperty;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *levelCn;
@property (nonatomic, strong) NSString *languageCn;
@property (nonatomic, strong) NSString *pid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
