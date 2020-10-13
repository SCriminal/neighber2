//
//  ModelRentInfo.h
//
//  Created by 林栋 隋 on 2020/3/25
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelRentInfo : NSObject

@property (nonatomic, assign) double displayMode;
@property (nonatomic, assign) double categoryId;
@property (nonatomic, strong) NSString *reviewerName;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double houseMode;
@property (nonatomic, assign) double direction;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *estateName;
@property (nonatomic, strong) NSString *publisherName;
@property (nonatomic, strong) NSString *contact;
@property (nonatomic, assign) double boardStatus;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, assign) double layoutToilet;
@property (nonatomic, assign) double estateId;
@property (nonatomic, assign) double reviewerId;
@property (nonatomic, assign) double lng;
@property (nonatomic, assign) double price;
@property (nonatomic, assign) double publisherId;
@property (nonatomic, assign) double totalFloor;
@property (nonatomic, strong) NSString *coverUrl;
@property (nonatomic, assign) double reviewTime;
@property (nonatomic, strong) NSString *contactPhone;
@property (nonatomic, assign) double pullTime;
@property (nonatomic, assign) double layoutBedroom;
@property (nonatomic, assign) double isTop;
@property (nonatomic, assign) double floor;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double putTime;
@property (nonatomic, strong) NSArray *urls;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double isRecommendation;
@property (nonatomic, assign) double floorage;
@property (nonatomic, assign) double layoutParlor;
@property (nonatomic, assign) double status;

//logical
@property (nonatomic, readonly) NSString *layoutShow;
@property (nonatomic, readonly) NSString *directionShow;
@property (nonatomic, readonly) NSString *rentModeShow;
@property (nonatomic, readonly) NSString *rentPriceTitleShow;
@property (nonatomic, readonly) NSString *rentPriceSubtitleShow;
@property (nonatomic, readonly) NSString *rentPriceUnitShow;

@property (nonatomic, readonly) NSString *floorShow;
@property (nonatomic, assign) int filterSoldPriceIndex;
@property (nonatomic, assign) int filterRentPriceIndex;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
