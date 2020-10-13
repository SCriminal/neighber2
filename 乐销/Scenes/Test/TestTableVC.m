//
//  TestTableVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "TestTableVC.h"
#import "JournalismListCell.h"
//request
#import "RequestApi+Neighbor.h"
#import "HouseKeepingView.h"

@interface TestTableVC ()
@property (nonatomic, assign) int index;
@property (nonatomic, strong) NSMutableArray *aryAunts;
@property (nonatomic, strong) NSMutableArray *aryOrganization;

@end

@implementation TestTableVC
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];

    //table
    [self.tableView registerClass:[HouseKeepingAuntCell class] forCellReuseIdentifier:@"HouseKeepingAuntCell"];
    [self.tableView registerClass:[HouseKeepingOrganizeCell class] forCellReuseIdentifier:@"HouseKeepingOrganizeCell"];

    [self addRefresh];
    //request
//    self.tableView.mj_footer.userInteractionEnabled = false;
       self.isRemoveAll = true;
       [self requestList];
}


#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.index == 0? self.aryAunts.count: self.aryOrganization.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.index == 0) {
          HouseKeepingAuntCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HouseKeepingAuntCell"];
          [cell resetCellWithModel:self.aryAunts[indexPath.row]];
          return cell;
    }
  
    HouseKeepingOrganizeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HouseKeepingOrganizeCell"];
    [cell resetCellWithModel:self.aryOrganization[indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.index == 0) {
        return [HouseKeepingAuntCell fetchHeight:self.aryAunts[indexPath.row]];
    }
    return [HouseKeepingOrganizeCell fetchHeight:self.aryOrganization[indexPath.row]];
}

#pragma mark request

- (void)requestList{
    self.aryOrganization = @[@"",@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy;
    self.aryAunts = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy;
    [self.tableView reloadData];
    
}
@end
