//
//  ModelFJNet.m
//
//  Created by 林栋 隋 on 2020/9/11
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelFJNet.h"


NSString *const kModelFJNetSmallImg = @"small_img";
NSString *const kModelFJNetId = @"id";
NSString *const kModelFJNetTitle = @"title";
NSString *const kModelFJNetAddtime = @"addtime";
NSString *const kModelFJNetTitColor = @"tit_color";


@interface ModelFJNet ()
@end

@implementation ModelFJNet

@synthesize smallImg = _smallImg;
@synthesize iDProperty = _iDProperty;
@synthesize title = _title;
@synthesize addtime = _addtime;
@synthesize titColor = _titColor;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.smallImg = [dict stringValueForKey:kModelFJNetSmallImg];
            self.iDProperty = [dict stringValueForKey:kModelFJNetId];
            self.title = [dict stringValueForKey:kModelFJNetTitle];
            self.addtime = [dict stringValueForKey:kModelFJNetAddtime];
            self.titColor = [dict stringValueForKey:kModelFJNetTitColor];
        self.smallImg = [self.smallImg findJobImage];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.smallImg forKey:kModelFJNetSmallImg];
    [mutableDict setValue:self.iDProperty forKey:kModelFJNetId];
    [mutableDict setValue:self.title forKey:kModelFJNetTitle];
    [mutableDict setValue:self.addtime forKey:kModelFJNetAddtime];
    [mutableDict setValue:self.titColor forKey:kModelFJNetTitColor];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
