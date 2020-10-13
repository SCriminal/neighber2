//
//  BaseTableVC+Authority.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/6.
//  Copyright © 2019 ping. All rights reserved.
//

#import "BaseTableVC+Authority.h"
static const char BaseTableVCAuthorityDicAllKey = '\0';

@implementation BaseTableVC (Authority)

- (void)setDicAuthorityAll:(NSMutableDictionary *)dicAuthorityAll{
    if (!dicAuthorityAll || [dicAuthorityAll isKindOfClass:NSMutableDictionary.class]) {
        objc_setAssociatedObject(self, &BaseTableVCAuthorityDicAllKey, dicAuthorityAll, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (NSMutableDictionary *)dicAuthorityAll{
    NSMutableDictionary * dic = objc_getAssociatedObject(self, &BaseTableVCAuthorityDicAllKey);
    if (!dic || [dic isKindOfClass:NSMutableDictionary.class]) {
        return dic;
    }
    return nil;
}


- (void)registAuthorityCell{
    self.tableView.backgroundColor = COLOR_GRAY;
    self.tableView.contentInset = UIEdgeInsetsMake(W(15), 0, 0, 0);
    self.dicAuthorityAll = [NSMutableDictionary dictionary];
    
    [self.tableView registerClass:[PerfectSelectCell class] forCellReuseIdentifier:@"PerfectSelectCell"];
    [self.tableView registerClass:[PerfectTextCell class] forCellReuseIdentifier:@"PerfectTextCell"];
    [self.tableView registerClass:[PerfectAddressDetailCell class] forCellReuseIdentifier:@"PerfectAddressDetailCell"];
    [self.tableView registerClass:[PerfectEmptyCell class] forCellReuseIdentifier:@"PerfectEmptyCell"];
    
}
- (UITableViewCell *)dequeueAuthorityCell:(NSIndexPath *)indexPath{
    ModelBaseData * model = self.aryDatas[indexPath.row];
    return  [self dequeueAuthorityCellWithModel:model];
}
- (UITableViewCell *)dequeueAuthorityCellWithModel:(ModelBaseData *)model{
    NSLog(@"sld_%p  %@",model,model.string);
    switch (model.enumType) {
        case ENUM_PERFECT_CELL_TEXT:
        {
            
            PerfectTextCell * textCell = [self.dicAuthorityAll objectForKey:[NSString stringWithFormat:@"%p",model]];
            if (textCell == nil) {
                textCell =  [[PerfectTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PerfectTextCell"];
                [self.dicAuthorityAll setObject:textCell forKey:[NSString stringWithFormat:@"%p",model]];
            }
            textCell.leftInterval = self.tableView.leftInterval;
            [textCell resetCellWithModel:model];
            return textCell;
        }
            break;
        case ENUM_PERFECT_CELL_SELECT:
        {
            PerfectSelectCell * selectCell = [self.dicAuthorityAll objectForKey:[NSString stringWithFormat:@"%p",model]];
            if (selectCell == nil) {
                selectCell =  [[PerfectSelectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PerfectSelectCell"];
                [self.dicAuthorityAll setObject:selectCell forKey:[NSString stringWithFormat:@"%p",model]];
            }
            selectCell.leftInterval = self.tableView.leftInterval;
            [selectCell resetCellWithModel:model];
            return selectCell;
        }
            break;
        case ENUM_PERFECT_CELL_ADDRESS:
        {
            PerfectAddressDetailCell * addressCell = [self.dicAuthorityAll objectForKey:[NSString stringWithFormat:@"%p",model]];
            if (addressCell == nil) {
                addressCell = [[PerfectAddressDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PerfectAddressDetailCell"];
                [self.dicAuthorityAll setObject:addressCell forKey:[NSString stringWithFormat:@"%p",model]];
            }
            [addressCell resetCellWithModel:model];
            return addressCell;
        }
            break;
        case ENUM_PERFECT_CELL_EMPTY:
        {
            PerfectEmptyCell * addressCell = [self.dicAuthorityAll objectForKey:[NSString stringWithFormat:@"%p",model]];
            if (addressCell == nil) {
                addressCell =  [[PerfectEmptyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PerfectEmptyCell"];
                [self.dicAuthorityAll setObject:addressCell forKey:[NSString stringWithFormat:@"%p",model]];
            }
            [addressCell resetCellWithModel:model];
            return addressCell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (CGFloat)fetchAuthorityCellHeight:(NSIndexPath *)indexPath{
    ModelBaseData * model = self.aryDatas[indexPath.row];
    return [self fetchAuthorityCellHeightWithModel:model];
}
- (CGFloat)fetchAuthorityCellHeightWithModel:(ModelBaseData *)model{
    switch (model.enumType) {
        case ENUM_PERFECT_CELL_TEXT:
        {
            return [PerfectTextCell fetchHeight:model];
        }
            break;
        case ENUM_PERFECT_CELL_SELECT:
        {
            return [PerfectSelectCell fetchHeight:model];
        }
            break;
        case ENUM_PERFECT_CELL_ADDRESS:
        {
            CGFloat height = [PerfectAddressDetailCell fetchHeight:model];
            return height;
        }
            break;
        case ENUM_PERFECT_CELL_EMPTY:
        {
            return [PerfectEmptyCell fetchHeight:model];
        }
            break;
        default:
            break;
    }
    return 0.00;
}
@end
