//
//  WhistleDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/18.
//Copyright © 2020 ping. All rights reserved.
//

#import "SecurityDetailVC.h"
//request
#import "RequestApi+Neighbor.h"
//图片选择collection
#import "Collection_Image.h"
#import "SecurityDetailView.h"

@interface SecurityDetailVC ()
@property (nonatomic, strong) Collection_Image *collection_Image;
@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) SecurityDetailTopView *topView;
@property (nonatomic, strong) SecurityDetailAddCommentView *addCommentView;
@property (nonatomic, strong) SecurityDetailStatusView *statusView;
@property (nonatomic, strong) ModelCommunityServiceList *modelDetail;
@property (nonatomic, strong) SecurityDetailCommentDetailView *commentDetailView;

@end

@implementation SecurityDetailVC
- (SecurityDetailCommentDetailView *)commentDetailView{
    if (!_commentDetailView) {
        _commentDetailView = [SecurityDetailCommentDetailView new];
    }
    return _commentDetailView;
}
- (SecurityDetailTopView *)topView{
    if (!_topView) {
        _topView = [SecurityDetailTopView new];
    }
    return _topView;
}
- (SecurityDetailAddCommentView *)addCommentView{
    if (!_addCommentView) {
        _addCommentView = [SecurityDetailAddCommentView new];
        WEAKSELF
        _addCommentView.btn.blockClick = ^{
            [weakSelf requestComment];
        };
    }
    return _addCommentView;
}

- (SecurityDetailStatusView *)statusView{
    if (!_statusView) {
        _statusView = [SecurityDetailStatusView new];
    }
    return _statusView;
}
- (Collection_Image *)collection_Image{
    if (!_collection_Image) {
        _collection_Image = [Collection_Image new];
        _collection_Image.isEditing = false;
        _collection_Image.width =  SCREEN_WIDTH - W(60);
        _collection_Image.left = W(10);
        [_collection_Image resetWithAry:nil];
        
    }
    return _collection_Image;
}
- (UIView *)header{
    if (!_header) {
        _header = [UIView new];
        _header.backgroundColor = [UIColor whiteColor];
        _header.width = SCREEN_WIDTH;
    }
    return _header;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
//    [self.tableView registerClass:[<#CellName#> class] forCellReuseIdentifier:@"<#CellName#>"];
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, iphoneXBottomInterval, 0);
    //request
    [self requestList];
    [self addObserveOfKeyboard];
}

- (void)config{
    [self.header removeAllSubViews];
    [self.header addSubview:self.topView ];
    
    self.collection_Image.top = self.topView.bottom + W(10);
    [self.header addSubview:self.collection_Image];
    
    self.statusView.top = self.collection_Image.bottom + W(13);
    [self.header addSubview:self.statusView];
    

    if (self.modelDetail.status == 9) {
        self.addCommentView.top = self.statusView.bottom;
        [self.header addSubview:self.addCommentView];
        self.header.height = self.addCommentView.bottom;

    }else if(self.modelDetail.status == 10){
        self.commentDetailView.top = self.statusView.bottom;
        [self.header addSubview:self.commentDetailView];
        self.header.height = self.commentDetailView.bottom;
    }else{
        self.header.height = self.statusView.bottom;
    }
    
    self.tableView.tableHeaderView = self.header;
    
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"详情" rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFLOAT_MIN;
}
//table header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
//table header
-(UIView *)tableView:(UITableView *)tableView viewForheaderInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForheaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

#pragma mark request
- (void)requestList{
    [RequestApi requestCommunityServiceDetailWithId:self.modelList.iDProperty scope:4 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelCommunityServiceList * modelDetail = [ModelCommunityServiceList modelObjectWithDictionary:response];
               self.modelDetail = modelDetail;
               [self.topView resetViewWithModel:modelDetail];
               [self.collection_Image resetWithAry:modelDetail.aryImages];
               [self.statusView resetViewWithModel:modelDetail];
               [self.commentDetailView resetViewWithModel:modelDetail];
               [self config];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
   
}

- (void)requestComment{
    if (!isStr(self.addCommentView.textView.text)) {
        [GlobalMethod showAlert:@"请输入评论内容"];
        return;
    }
    if (self.addCommentView.starView.currentScore == 0 ) {
        [GlobalMethod showAlert:@"请选择满意程度"];
        return;
    }
    [RequestApi requestCommunityServiceCommentWithScore:self.addCommentView.starView.currentScore evaluation:self.addCommentView.textView.text id:self.modelList.iDProperty  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.requestState = 1;
        [self requestList];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
@end
