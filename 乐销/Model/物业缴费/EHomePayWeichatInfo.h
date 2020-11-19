//
//  EHomePayWeichatInfo.h
//
//  Created by 林栋 隋 on 2020/10/12
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EHomePayWeichatInfo : NSObject

@property (nonatomic, strong) NSString *epishopId;
@property (nonatomic, strong) NSString *epiKey;
@property (nonatomic, strong) NSString *feesIds;
@property (nonatomic, strong) NSString *payOrderNo;
@property (nonatomic, assign) double fee;
@property (nonatomic, strong) NSString *notifyUrl;
@property (nonatomic, strong) NSString *orderTitle;
@property (nonatomic, strong) NSString *orderDesc;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
