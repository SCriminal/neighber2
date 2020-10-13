//
//  SubModuleView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/6/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "SubModuleView.h"
#import "ModuleCollectionView.h"
#import "RequestApi+Neighbor.h"

@interface SubModuleView()
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) UIImageView *BG;
@property (strong, nonatomic) UIImageView *whiteBG;
@property (nonatomic, strong) ModuleCollectionView *collection;

@end

@implementation SubModuleView
- (ModuleCollectionView *)collection{
    if (!_collection) {
        _collection = [[ModuleCollectionView alloc]initWithNum:5];
        _collection.top = self.BG.bottom;
    }
    return _collection;
}

- (BaseNavView *)nav{
    if (!_nav) {
        _nav = [BaseNavView initNavBackTitle:@"" rightView:nil];
        _nav.backgroundColor = [UIColor clearColor];
        WEAKSELF
        _nav.blockBack = ^{
            [weakSelf removeFromSuperview];
        };
    }
    return _nav;
}
- (UIImageView *)BG{
    if (_BG == nil) {
        _BG = [UIImageView new];
        NSString * imageName = nil;
        switch (self.serviceType) {
            case ENUM_SUB_MODULE_TYPE_SECURITY:
                imageName = @"securityService_topBG";
                break;
            case ENUM_SUB_MODULE_TYPE_PUBLIC_SERVICE:
                imageName = @"publicservice_topBG";
                break;
            case ENUM_SUB_MODULE_TYPE_HOUSEHOLD:
                imageName = @"household_topBG";
                break;
            case ENUM_SUB_MODULE_TYPE_HOSPITAL:
                imageName = @"hospital_topBG";
                break;
            case ENUM_SUB_MODULE_TYPE_GOVERMENT:
                imageName = @"government_topBG";
                break;
            case ENUM_SUB_MODULE_TYPE_PROPERTY:
                imageName = @"property_topBG";
                break;
            case ENUM_SUB_MODULE_TYPE_COMMUNITY:
                imageName = @"community_topBG";
                break;
                case ENUM_SUB_MODULE_TYPE_KUIWEN:
                imageName = @"kuiwen_topBG";
                break;
            default:
                break;
        }
        _BG.image = [UIImage imageNamed:imageName];
        _BG.contentMode = UIViewContentModeScaleAspectFill;
        _BG.clipsToBounds = true;
        _BG.widthHeight = XY(SCREEN_WIDTH, W(135)+iphoneXTopInterval);
    }
    return _BG;
}
- (UIImageView *)whiteBG{
    if (_whiteBG == nil) {
        _whiteBG = [UIImageView new];
        _whiteBG.clipsToBounds = true;
        _whiteBG.backgroundColor = [UIColor clearColor];
        _whiteBG.widthHeight = XY(SCREEN_WIDTH,15);
        {
            UIView * view = [UIView new];
            view.backgroundColor = [UIColor whiteColor];
            view.widthHeight = XY(SCREEN_WIDTH, 30);
            [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:15 lineWidth:0 lineColor:[UIColor clearColor]];
            [_whiteBG addSubview:view];
        }
    }
    return _whiteBG;
}

- (instancetype)initWithType:(ENUM_SUB_MODULE_TYPE )type{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.serviceType = type;
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.height = SCREEN_HEIGHT - TABBAR_HEIGHT;
        self.clipsToBounds = true;
        [self addSubView];
        [self requestModule];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.BG];
    [self addSubview:self.nav];
    [self addSubview:self.whiteBG];
    [self addSubview:self.collection];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.whiteBG.bottom = self.BG.bottom;
}

- (void)requestModule{
    NSString * strAlias = nil;
    switch (self.serviceType) {
        case ENUM_SUB_MODULE_TYPE_HOSPITAL:
            strAlias = @"resident_hospital";
            break;
        case ENUM_SUB_MODULE_TYPE_PUBLIC_SERVICE:
            strAlias = @"resident_public";
            break;
        case ENUM_SUB_MODULE_TYPE_SECURITY:
            strAlias = @"resident_security";
            break;
        case ENUM_SUB_MODULE_TYPE_HOUSEHOLD:
            strAlias = @"resident_housekeeping";
            break;
        case ENUM_SUB_MODULE_TYPE_GOVERMENT:
            strAlias = @"resident_gov";
            break;
        case ENUM_SUB_MODULE_TYPE_PROPERTY:
            strAlias = @"resident_property";
            break;
        case ENUM_SUB_MODULE_TYPE_COMMUNITY:
            strAlias = @"resident_estate";
            break;
            case ENUM_SUB_MODULE_TYPE_KUIWEN:
            strAlias = @"resident_party";
            break;
        default:
            break;
    }
    [RequestApi requestModuleWithLocationaliases:strAlias areaId:[GlobalData sharedInstance].community.iDProperty delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:strAlias] toAryWithModelName:@"ModelModule"];
        if (isAry(aryResponse)) {
            [self.collection resetWithAry:aryResponse];
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

@end
