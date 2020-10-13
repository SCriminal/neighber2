//
//  ModelUser.h
//
//  Created by sld s on 2019/5/17
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelUser : NSObject

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, assign) double gender;
@property (nonatomic, strong) NSString *headUrl;
@property (nonatomic, strong) NSString *estateId;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *estateName;
@property (nonatomic, strong) NSString *addr;



+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
