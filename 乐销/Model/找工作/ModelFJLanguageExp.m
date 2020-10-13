//
//  ModelFJLanguageExp.m
//
//  Created by 林栋 隋 on 2020/9/16
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelFJLanguageExp.h"


NSString *const kModelFJLanguageExpUid = @"uid";
NSString *const kModelFJLanguageExpId = @"id";
NSString *const kModelFJLanguageExpLevel = @"level";
NSString *const kModelFJLanguageExpLanguage = @"language";
NSString *const kModelFJLanguageExpLevelCn = @"level_cn";
NSString *const kModelFJLanguageExpLanguageCn = @"language_cn";
NSString *const kModelFJLanguageExpPid = @"pid";


@interface ModelFJLanguageExp ()
@end

@implementation ModelFJLanguageExp

@synthesize uid = _uid;
@synthesize iDProperty = _iDProperty;
@synthesize level = _level;
@synthesize language = _language;
@synthesize levelCn = _levelCn;
@synthesize languageCn = _languageCn;
@synthesize pid = _pid;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.uid = [dict stringValueForKey:kModelFJLanguageExpUid];
            self.iDProperty = [dict stringValueForKey:kModelFJLanguageExpId];
            self.level = [dict stringValueForKey:kModelFJLanguageExpLevel];
            self.language = [dict stringValueForKey:kModelFJLanguageExpLanguage];
            self.levelCn = [dict stringValueForKey:kModelFJLanguageExpLevelCn];
            self.languageCn = [dict stringValueForKey:kModelFJLanguageExpLanguageCn];
            self.pid = [dict stringValueForKey:kModelFJLanguageExpPid];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.uid forKey:kModelFJLanguageExpUid];
    [mutableDict setValue:self.iDProperty forKey:kModelFJLanguageExpId];
    [mutableDict setValue:self.level forKey:kModelFJLanguageExpLevel];
    [mutableDict setValue:self.language forKey:kModelFJLanguageExpLanguage];
    [mutableDict setValue:self.levelCn forKey:kModelFJLanguageExpLevelCn];
    [mutableDict setValue:self.languageCn forKey:kModelFJLanguageExpLanguageCn];
    [mutableDict setValue:self.pid forKey:kModelFJLanguageExpPid];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
