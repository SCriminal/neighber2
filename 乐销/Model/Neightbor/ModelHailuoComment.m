//
//  ModelHailuoComment.m
//
//  Created by 林栋 隋 on 2020/8/18
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelHailuoComment.h"


NSString *const kModelHailuoCommentNickName = @"nick_name";
NSString *const kModelHailuoCommentServeName = @"serve_name";
NSString *const kModelHailuoCommentStart = @"start";
NSString *const kModelHailuoCommentCreateTime = @"create_time";
NSString *const kModelHailuoCommentPhoto = @"photo";
NSString *const kModelHailuoCommentComment = @"comment";
NSString *const kModelHailuoCommentIcon = @"icon";


@interface ModelHailuoComment ()
@end

@implementation ModelHailuoComment

@synthesize nickName = _nickName;
@synthesize serveName = _serveName;
@synthesize start = _start;
@synthesize createTime = _createTime;
@synthesize photo = _photo;
@synthesize comment = _comment;
@synthesize icon = _icon;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.nickName = [dict stringValueForKey:kModelHailuoCommentNickName];
            self.serveName = [dict stringValueForKey:kModelHailuoCommentServeName];
            self.start = [dict doubleValueForKey:kModelHailuoCommentStart];
            self.createTime = [dict doubleValueForKey:kModelHailuoCommentCreateTime];
            self.comment = [dict stringValueForKey:kModelHailuoCommentComment];
            self.icon = [dict stringValueForKey:kModelHailuoCommentIcon];

        NSMutableArray * ary = [NSMutableArray new];
        NSArray * aryImage = [dict arrayValueForKey:kModelHailuoCommentPhoto];
        for (NSString * strUrl in aryImage) {
            [ary addObject:[strUrl hailuoImage]];
        }
        self.photo = ary;
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kModelHailuoCommentNickName];
    [mutableDict setValue:self.serveName forKey:kModelHailuoCommentServeName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.start] forKey:kModelHailuoCommentStart];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelHailuoCommentCreateTime];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.photo] forKey:kModelHailuoCommentPhoto];
    [mutableDict setValue:self.comment forKey:kModelHailuoCommentComment];
    [mutableDict setValue:self.icon forKey:kModelHailuoCommentIcon];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
