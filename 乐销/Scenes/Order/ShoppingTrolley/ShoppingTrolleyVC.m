//
//  ShoppingTrolleyVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "ShoppingTrolleyVC.h"
//subview
#import "ShoppingTrolleyView.h"
//request
#import "RequestApi+Neighbor.h"
//vc
#import "ConfirmOrderVC.h"

@interface ShoppingTrolleyVC ()
@property (nonatomic, strong) ShoppingTrolleyBottomView *bottomView;
@property (nonatomic, strong) NSMutableArray *arySelected;

@end

@implementation ShoppingTrolleyVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_trolley" title:@"暂无商品"];
    }
    return _noResultView;
}
- (NSMutableArray *)arySelected{
    if (!_arySelected) {
        _arySelected = [NSMutableArray new];
    }
    return _arySelected;
}
- (ShoppingTrolleyBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [ShoppingTrolleyBottomView new];
        _bottomView.bottom = SCREEN_HEIGHT;
        WEAKSELF
        _bottomView.blockSelectAll = ^(BOOL selectAll) {
            if (selectAll) {
                [weakSelf.arySelected removeAllObjects];
                [weakSelf.arySelected addObjectsFromArray:[weakSelf.aryDatas fetchValuesComponentAry:@"skus"]];
            }else{
                [weakSelf.arySelected removeAllObjects];
            }
            for (ModelIntegralProduct *modelP in [weakSelf.aryDatas fetchValuesComponentAry:@"skus"]) {
                modelP.selected = selectAll;
            }
            [weakSelf.tableView reloadData];
            [weakSelf.bottomView resetViewWithModel:weakSelf.arySelected];
            weakSelf.bottomView.ivSelected.highlighted = [weakSelf isSelectedAll];
        };
        _bottomView.blockSubmitClick = ^{
            if (weakSelf.arySelected.count == 0) {
                [GlobalMethod showAlert:@"请先添加商品"];
                return;
            }
            ConfirmOrderVC * confirmVC = [ConfirmOrderVC new];
            NSMutableArray * aryReturn = [GlobalMethod exchangeDic:[GlobalMethod exchangeAryModelToAryDic:weakSelf.aryDatas] toAryWithModelName:@"ModelTrolley"];
            for (ModelTrolley * modelTrolley in aryReturn) {
                for (ModelIntegralProduct * obj in modelTrolley.skus.reverseObjectEnumerator) {
                    if (!obj.selected) {
                        [modelTrolley.skus removeObject:obj];
                    }
                }
                
            }
            for (ModelTrolley * obj in aryReturn.reverseObjectEnumerator) {
                if (obj.skus.count == 0) {
                    [aryReturn removeObject:obj];
                }
            }
            confirmVC.aryDatas = aryReturn;
            confirmVC.blockBack = ^(UIViewController *vc) {
                [weakSelf refreshHeaderAll];
            };
            [GB_Nav pushViewController:confirmVC animated:true];
        };
    }
    return _bottomView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.bottomView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshHeaderAll) name:NOTICE_TROLLEY_EXCHANGE object:nil];
    self.tableView.height = SCREEN_HEIGHT - self.bottomView.height - NAVIGATIONBAR_HEIGHT;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, W(20), 0);
    //table
    [self.tableView registerClass:[ShoppingTrolleyCell class] forCellReuseIdentifier:@"ShoppingTrolleyCell"];
    self.tableView.backgroundColor = COLOR_GRAY;
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"购物车" rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ModelTrolley * model = self.aryDatas[section];
    return model.skus.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.aryDatas.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelTrolley * model = self.aryDatas[indexPath.section];
    
    ShoppingTrolleyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingTrolleyCell"];
    [cell resetCellWithModel:model.skus[indexPath.row]];
    WEAKSELF
    cell.blockMinusClick = ^(ModelIntegralProduct *item) {
        if (item.qty == 1) {
            [weakSelf requestDelete:item];
        }else{
            [weakSelf requestChangeNum:item isAdd:false];
        }
    };
    cell.blockAddClick = ^(ModelIntegralProduct *item) {
        [weakSelf requestChangeNum:item isAdd:true];
    };
    cell.blockSelected  = ^(ModelIntegralProduct *item) {
        if (item.selected) {
            [weakSelf.arySelected addObject:item];
        }else{
            ModelIntegralProduct * modelSelected = [weakSelf.arySelected fetchSameModelKeyPath:@"code" model:item];
            if (modelSelected) {
                [weakSelf.arySelected removeObject:modelSelected];
            }
        }
        [weakSelf.tableView reloadData];
        [weakSelf.bottomView resetViewWithModel:weakSelf.arySelected];
        weakSelf.bottomView.ivSelected.highlighted = [weakSelf isSelectedAll];

    };
    return cell;
    
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加一个'删除'按钮
    WEAKSELF
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        ModelTrolley *item = weakSelf.aryDatas[indexPath.section];
        [weakSelf requestDelete:item.skus[indexPath.row]];
    }];
    //将设置好的按钮放到数组中返回
    return @[deleteRowAction];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelTrolley * model = self.aryDatas[indexPath.section];
    return [ShoppingTrolleyCell fetchHeight:model.skus[indexPath.row]];
}
//table header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ShoppingTrolleySectionTopView * topView = [ShoppingTrolleySectionTopView new];
    [topView resetViewWithModel:self.aryDatas[section]];
    WEAKSELF
    topView.blockSelect = ^(BOOL isSelected,ModelTrolley * model) {
        for (ModelIntegralProduct * modelPro in model.skus) {
            if (modelPro.selected != isSelected) {
                modelPro.selected = isSelected;
                if (isSelected) {
                    [weakSelf.arySelected addObject:modelPro];
                }else{
                    ModelIntegralProduct * modelSelected = [weakSelf.arySelected fetchSameModelKeyPath:@"code" model:modelPro];
                    if (modelSelected) {
                        [weakSelf.arySelected removeObject:modelSelected];
                    }
                }
            }
        }
        [weakSelf.bottomView resetViewWithModel:weakSelf.arySelected];
        weakSelf.bottomView.ivSelected.highlighted = [weakSelf isSelectedAll];
        [weakSelf.tableView reloadData];
    };
    return  topView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    static CGFloat headerHeight = 0;
    if (!headerHeight) {
        headerHeight = [ShoppingTrolleySectionTopView new].height;
    }
    return headerHeight;
}
//table footer
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return  [ShoppingTrolleySectionBottomView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    static CGFloat footerHeight = 0;
    if (!footerHeight) {
        footerHeight = [ShoppingTrolleySectionBottomView new].height;
    }
    return footerHeight;
    
}
- (Boolean)isSelectedAll{
    if (self.aryDatas.count) {
        for (ModelTrolley * modelTrolley in self.aryDatas) {
            for (ModelIntegralProduct * modelPro in modelTrolley.skus) {
                if (!modelPro.selected) {
                    return false;
                }
            }
        }
        return true;
    }
    return false;
}
#pragma mark request
- (void)requestList{
    [RequestApi requestTrolleyDetailWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.aryDatas = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelTrolley"];
        NSMutableDictionary * dicResponse = [[self.aryDatas fetchValuesComponentAry:@"skus"] exchangeDicWithKeyPath:@"code"];
        for (ModelIntegralProduct* pro in self.arySelected.reverseObjectEnumerator) {
            ModelIntegralProduct * modelSelected = [dicResponse objectForKey:pro.code];
            if (modelSelected) {
                modelSelected.selected = true;
                [self.arySelected replaceObjectAtIndex:[self.arySelected indexOfObject:pro] withObject:modelSelected];
            }else{
                modelSelected.selected = false;
                [self.arySelected removeObject:pro];
            }
            
        }
        
        [self.bottomView resetViewWithModel:self.arySelected];
        self.bottomView.ivSelected.highlighted = [self isSelectedAll];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
- (void)requestChangeNum:(ModelIntegralProduct *)item isAdd:(BOOL)isAdd{
    [RequestApi requestChangeTrolleyNumWithId:item.code qty:isAdd?item.qty+1:item.qty-1 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestDelete:(ModelIntegralProduct *)item{
    [RequestApi requestDeleteTrolleyWithIds:item.code scope:@"" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
