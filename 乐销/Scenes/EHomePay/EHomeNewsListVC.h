//
//  EHomeNewsListVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/11/11.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface EHomeNewsListVC : BaseTableVC

@end
@class ModelEHomeNotice;
@interface EHomeNewsListCell : UITableViewCell

@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UIImageView *icon;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelEHomeNotice *)model;


@end


@interface ModelEHomeNotice : NSObject

@property (nonatomic, strong) NSString *notice;
@property (nonatomic, assign) double pageSize;
@property (nonatomic, strong) NSString *iDProperty;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *typeName;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) double page;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
