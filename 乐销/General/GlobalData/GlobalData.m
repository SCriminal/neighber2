//
//  GlobalData.m
//  ChinaDream
//
//  Created by zhangfeng on 12-11-26.
//  Copyright (c) 2012年 eastedge. All rights reserved.
//

#import "GlobalData.h"

UINavigationController *GB_Nav = nil;

@implementation GlobalData
@synthesize GB_UserModel = _GB_UserModel;
@synthesize GB_Key = _GB_Key;
@synthesize community = _community;
@synthesize modelHaiLuo = _modelHaiLuo;
@synthesize modelFindJob = _modelFindJob;
@synthesize modelEHome = _modelEHome;
@synthesize modelEHomeArchive = _modelEHomeArchive;


#pragma mark 实现单例
SYNTHESIZE_SINGLETONE_FOR_CLASS(GlobalData);

- (instancetype)init{
    self = [super init];
    if (self) {
        //初始化状态栏
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
    return self;
}
//set get userModel
- (void)setGB_UserModel:(ModelUser *)GB_UserModel{
    [GlobalMethod writeModel:GB_UserModel key:LOCAL_USERMODEL];
    _GB_UserModel = GB_UserModel;
    
    if (GB_UserModel) {
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_SELFMODEL_CHANGE object:nil];
    }
}
- (ModelUser *)GB_UserModel{
    if (!_GB_UserModel.nickname) {
        NSDictionary * dicItem = [GlobalMethod exchangeStringToDic:[GlobalMethod readStrFromUser:LOCAL_USERMODEL]];
        _GB_UserModel = [ModelUser modelObjectWithDictionary:dicItem];
    }
    return _GB_UserModel;
}
- (ModelHaiLuo *)modelHaiLuo{
    if (!_modelHaiLuo ) {
        NSDictionary * dicItem = [GlobalMethod exchangeStringToDic:[GlobalMethod readStrFromUser:LOCAL_HAILUOMODEL]];
        _modelHaiLuo = [ModelHaiLuo modelObjectWithDictionary:dicItem];
    }
    return _modelHaiLuo;
}
- (void)setModelHaiLuo:(ModelHaiLuo *)modelHaiLuo{
    [GlobalMethod writeModel:modelHaiLuo key:LOCAL_HAILUOMODEL];   
    _modelHaiLuo = modelHaiLuo;
}

- (ModelHaiLuo *)modelFindJob{
    if (!_modelFindJob ) {
        NSDictionary * dicItem = [GlobalMethod exchangeStringToDic:[GlobalMethod readStrFromUser:LOCAL_FINDJOBMODEL]];
        _modelFindJob = [ModelHaiLuo modelObjectWithDictionary:dicItem];
    }
    return _modelFindJob;
}
- (void)setModelFindJob:(ModelHaiLuo *)modelFindJob{
    [GlobalMethod writeModel:modelFindJob key:LOCAL_FINDJOBMODEL];
    _modelFindJob = modelFindJob;
}

- (ModelArchiveList *)modelEHomeArchive{
    if (!_modelEHomeArchive ) {
           NSDictionary * dicItem = [GlobalMethod exchangeStringToDic:[GlobalMethod readStrFromUser:LOCAL_EHOMEARCHIVE]];
           _modelEHomeArchive = [ModelArchiveList modelObjectWithDictionary:dicItem];
       }
       return _modelEHomeArchive;
}
- (void)setModelEHomeArchive:(ModelArchiveList *)modelEHomeArchive{
    [GlobalMethod writeModel:modelEHomeArchive key:LOCAL_EHOMEARCHIVE];
    _modelEHomeArchive = modelEHomeArchive;
}

- (ModelHaiLuo *)modelEHome{
    if (!_modelEHome ) {
        NSDictionary * dicItem = [GlobalMethod exchangeStringToDic:[GlobalMethod readStrFromUser:LOCAL_EHOMEMODEL]];
        _modelEHome = [ModelHaiLuo modelObjectWithDictionary:dicItem];
    }
    return _modelEHome;
}
- (void)setModelEHome:(ModelHaiLuo *)modelEHome{
    [GlobalMethod writeModel:modelEHome key:LOCAL_EHOMEMODEL];
    _modelEHome = modelEHome;
}
//set get key
- (void)setGB_Key:(NSString *)GB_Key{
    [GlobalMethod writeStr:GB_Key!=nil?GB_Key:@"" forKey:LOCAL_KEY];
    _GB_Key = GB_Key;
}
- (NSString*)GB_Key{
    if (!isStr(_GB_Key)){
        _GB_Key = [GlobalMethod readStrFromUser:LOCAL_KEY];
    }
    return _GB_Key;
}

//set get key
- (void)setCommunity:(ModelCommunity *)community{
    _community = community;
    [GlobalMethod writeModel:community key:LOCAL_COMMUNITY exchange:false];
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_COMMUNITY_REFERSH object:nil];
}
-(ModelCommunity *)community{
    if (!_community.iDProperty) {
        NSDictionary * dicItem = [GlobalMethod exchangeStringToDic:[GlobalMethod readStrFromUser:LOCAL_COMMUNITY exchange:false]];
        _community = [ModelCommunity modelObjectWithDictionary:dicItem];
    }
    return _community;
}

#pragma mark lazy init
//set Notice View
- (NoticeView *)GB_NoticeView{
    if (_GB_NoticeView == nil) {
        _GB_NoticeView = [NoticeView new];
    }
    return _GB_NoticeView;
}

+ (void)saveUserModel{
    [GlobalData sharedInstance].GB_UserModel = [GlobalData sharedInstance].GB_UserModel;
}

@end
