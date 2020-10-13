//
//  ModelFJNet.h
//
//  Created by 林栋 隋 on 2020/9/11
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelFJNet : NSObject

@property (nonatomic, strong) NSString *smallImg;
@property (nonatomic, strong) NSString *iDProperty;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *titColor;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
