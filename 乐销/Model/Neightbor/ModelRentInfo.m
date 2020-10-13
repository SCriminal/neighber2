//
//  ModelRentInfo.m
//
//  Created by 林栋 隋 on 2020/3/25
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelRentInfo.h"


NSString *const kModelRentInfoDisplayMode = @"displayMode";
NSString *const kModelRentInfoCategoryId = @"categoryId";
NSString *const kModelRentInfoReviewerName = @"reviewerName";
NSString *const kModelRentInfoId = @"id";
NSString *const kModelRentInfoHouseMode = @"houseMode";
NSString *const kModelRentInfoDirection = @"direction";
NSString *const kModelRentInfoBody = @"body";
NSString *const kModelRentInfoEstateName = @"estateName";
NSString *const kModelRentInfoPublisherName = @"publisherName";
NSString *const kModelRentInfoContact = @"contact";
NSString *const kModelRentInfoBoardStatus = @"boardStatus";
NSString *const kModelRentInfoCategoryName = @"categoryName";
NSString *const kModelRentInfoLayoutToilet = @"layoutToilet";
NSString *const kModelRentInfoEstateId = @"estateId";
NSString *const kModelRentInfoReviewerId = @"reviewerId";
NSString *const kModelRentInfoLng = @"lng";
NSString *const kModelRentInfoPrice = @"price";
NSString *const kModelRentInfoPublisherId = @"publisherId";
NSString *const kModelRentInfoTotalFloor = @"totalFloor";
NSString *const kModelRentInfoCoverUrl = @"coverUrl";
NSString *const kModelRentInfoReviewTime = @"reviewTime";
NSString *const kModelRentInfoContactPhone = @"contactPhone";
NSString *const kModelRentInfoPullTime = @"pullTime";
NSString *const kModelRentInfoLayoutBedroom = @"layoutBedroom";
NSString *const kModelRentInfoIsTop = @"isTop";
NSString *const kModelRentInfoFloor = @"floor";
NSString *const kModelRentInfoLat = @"lat";
NSString *const kModelRentInfoPutTime = @"putTime";
NSString *const kModelRentInfoUrls = @"urls";
NSString *const kModelRentInfoTitle = @"title";
NSString *const kModelRentInfoIsRecommendation = @"isRecommendation";
NSString *const kModelRentInfoFloorage = @"floorage";
NSString *const kModelRentInfoLayoutParlor = @"layoutParlor";
NSString *const kModelRentInfoStatus = @"status";


@interface ModelRentInfo ()
@end

@implementation ModelRentInfo

@synthesize displayMode = _displayMode;
@synthesize categoryId = _categoryId;
@synthesize reviewerName = _reviewerName;
@synthesize iDProperty = _iDProperty;
@synthesize houseMode = _houseMode;
@synthesize direction = _direction;
@synthesize body = _body;
@synthesize estateName = _estateName;
@synthesize publisherName = _publisherName;
@synthesize contact = _contact;
@synthesize boardStatus = _boardStatus;
@synthesize categoryName = _categoryName;
@synthesize layoutToilet = _layoutToilet;
@synthesize estateId = _estateId;
@synthesize reviewerId = _reviewerId;
@synthesize lng = _lng;
@synthesize price = _price;
@synthesize publisherId = _publisherId;
@synthesize totalFloor = _totalFloor;
@synthesize coverUrl = _coverUrl;
@synthesize reviewTime = _reviewTime;
@synthesize contactPhone = _contactPhone;
@synthesize pullTime = _pullTime;
@synthesize layoutBedroom = _layoutBedroom;
@synthesize isTop = _isTop;
@synthesize floor = _floor;
@synthesize lat = _lat;
@synthesize putTime = _putTime;
@synthesize urls = _urls;
@synthesize title = _title;
@synthesize isRecommendation = _isRecommendation;
@synthesize floorage = _floorage;
@synthesize layoutParlor = _layoutParlor;

- (NSString *)floorShow{
    return self.totalFloor? [NSString stringWithFormat:@"第%.f层/共%.f层",self.floor,self.totalFloor]:@"";
}
- (NSString *)layoutShow{
    NSString * strBed = self.layoutBedroom?[NSString stringWithFormat:@"%.f室",self.layoutBedroom]:@"";
    NSString * strParlor = self.layoutParlor?[NSString stringWithFormat:@"%.f厅",self.layoutParlor]:@"";
    NSString * strToilet = self.layoutToilet?[NSString stringWithFormat:@"%.f卫",self.layoutToilet]:@"";
    return [NSString stringWithFormat:@"%@%@%@",strBed,strParlor,strToilet];

}
- (NSString *)directionShow{
    // 1东 2南 3西 4北 5东南 6西南 7西北  8东北
    switch ((int)self.direction) {
        case 1:
            return @"朝东";
            break;
        case 2:
            return @"朝南";
            break;
        case 3:
            return @"朝西";
            break;
        case 4:
            return @"朝北";
            break;
        case 5:
            return @"朝东南";
            break;
        case 6:
            return @"朝西南";
            break;
        case 7:
            return @"朝西北";
            break;
        case 8:
            return @"东北";
            break;
        default:
            break;
    }
    return @"";
}
- (NSString *)rentModeShow{
    switch ((int)self.houseMode) {
        case 1:
            return @"整租";
            break;
        case 2:
            return @"合租";
            break;
        case 3:
            return @"出售";
            break;
    }
    return @"";
}
-(NSString *)rentPriceTitleShow{
    switch ((int)self.houseMode) {
        case 1:
            return @"租金";
            break;
        case 2:
            return @"租金";
            break;
        case 3:
            return @"出售价格";
            break;
    }
    return @"租金";
}
-(NSString *)rentPriceSubtitleShow{
    switch ((int)self.houseMode) {
        case 1:
            return @"请输入租金/月(元)";
            break;
        case 2:
            return @"请输入租金/月(元)";
            break;
        case 3:
            return @"请输入出售价格(元)";
            break;
    }
    return @"请输入租金/月(元)";
}
-(NSString *)rentPriceUnitShow{
    switch ((int)self.houseMode) {
        case 1:
            return @"元/月";
            break;
        case 2:
            return @"元/月";
            break;
        case 3:
            return @"元";
            break;
    }
    return @"元/月";
}
#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.displayMode = [dict doubleValueForKey:kModelRentInfoDisplayMode];
            self.categoryId = [dict doubleValueForKey:kModelRentInfoCategoryId];
            self.reviewerName = [dict stringValueForKey:kModelRentInfoReviewerName];
            self.iDProperty = [dict doubleValueForKey:kModelRentInfoId];
            self.houseMode = [dict doubleValueForKey:kModelRentInfoHouseMode];
            self.direction = [dict doubleValueForKey:kModelRentInfoDirection];
            self.body = [dict stringValueForKey:kModelRentInfoBody];
            self.estateName = [dict stringValueForKey:kModelRentInfoEstateName];
            self.publisherName = [dict stringValueForKey:kModelRentInfoPublisherName];
            self.contact = [dict stringValueForKey:kModelRentInfoContact];
            self.boardStatus = [dict doubleValueForKey:kModelRentInfoBoardStatus];
            self.categoryName = [dict stringValueForKey:kModelRentInfoCategoryName];
            self.layoutToilet = [dict doubleValueForKey:kModelRentInfoLayoutToilet];
            self.estateId = [dict doubleValueForKey:kModelRentInfoEstateId];
            self.reviewerId = [dict doubleValueForKey:kModelRentInfoReviewerId];
            self.lng = [dict doubleValueForKey:kModelRentInfoLng];
            self.price = [dict doubleValueForKey:kModelRentInfoPrice];
            self.publisherId = [dict doubleValueForKey:kModelRentInfoPublisherId];
            self.totalFloor = [dict doubleValueForKey:kModelRentInfoTotalFloor];
            self.coverUrl = [dict stringValueForKey:kModelRentInfoCoverUrl];
            self.reviewTime = [dict doubleValueForKey:kModelRentInfoReviewTime];
            self.contactPhone = [dict stringValueForKey:kModelRentInfoContactPhone];
            self.pullTime = [dict doubleValueForKey:kModelRentInfoPullTime];
            self.layoutBedroom = [dict doubleValueForKey:kModelRentInfoLayoutBedroom];
            self.isTop = [dict doubleValueForKey:kModelRentInfoIsTop];
            self.floor = [dict doubleValueForKey:kModelRentInfoFloor];
            self.lat = [dict doubleValueForKey:kModelRentInfoLat];
            self.putTime = [dict doubleValueForKey:kModelRentInfoPutTime];
        self.urls =  [dict objectForKey:kModelRentInfoUrls];
            self.title = [dict stringValueForKey:kModelRentInfoTitle];
            self.isRecommendation = [dict doubleValueForKey:kModelRentInfoIsRecommendation];
            self.floorage = [dict doubleValueForKey:kModelRentInfoFloorage];
            self.layoutParlor = [dict doubleValueForKey:kModelRentInfoLayoutParlor];
        self.status = [dict doubleValueForKey:kModelRentInfoStatus];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.displayMode] forKey:kModelRentInfoDisplayMode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.categoryId] forKey:kModelRentInfoCategoryId];
    [mutableDict setValue:self.reviewerName forKey:kModelRentInfoReviewerName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelRentInfoId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.houseMode] forKey:kModelRentInfoHouseMode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.direction] forKey:kModelRentInfoDirection];
    [mutableDict setValue:self.body forKey:kModelRentInfoBody];
    [mutableDict setValue:self.estateName forKey:kModelRentInfoEstateName];
    [mutableDict setValue:self.publisherName forKey:kModelRentInfoPublisherName];
    [mutableDict setValue:self.contact forKey:kModelRentInfoContact];
    [mutableDict setValue:[NSNumber numberWithDouble:self.boardStatus] forKey:kModelRentInfoBoardStatus];
    [mutableDict setValue:self.categoryName forKey:kModelRentInfoCategoryName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.layoutToilet] forKey:kModelRentInfoLayoutToilet];
    [mutableDict setValue:[NSNumber numberWithDouble:self.estateId] forKey:kModelRentInfoEstateId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewerId] forKey:kModelRentInfoReviewerId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lng] forKey:kModelRentInfoLng];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kModelRentInfoPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.publisherId] forKey:kModelRentInfoPublisherId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalFloor] forKey:kModelRentInfoTotalFloor];
    [mutableDict setValue:self.coverUrl forKey:kModelRentInfoCoverUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewTime] forKey:kModelRentInfoReviewTime];
    [mutableDict setValue:self.contactPhone forKey:kModelRentInfoContactPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pullTime] forKey:kModelRentInfoPullTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.layoutBedroom] forKey:kModelRentInfoLayoutBedroom];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isTop] forKey:kModelRentInfoIsTop];
    [mutableDict setValue: [NSNumber numberWithDouble:self.floor] forKey:kModelRentInfoFloor];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kModelRentInfoLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.putTime] forKey:kModelRentInfoPutTime];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.urls] forKey:kModelRentInfoUrls];
    [mutableDict setValue:self.title forKey:kModelRentInfoTitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isRecommendation] forKey:kModelRentInfoIsRecommendation];
    [mutableDict setValue:[NSNumber numberWithDouble:self.floorage] forKey:kModelRentInfoFloorage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.layoutParlor] forKey:kModelRentInfoLayoutParlor];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kModelRentInfoStatus];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
