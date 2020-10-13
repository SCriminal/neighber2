//
//  PartyEliteDownloadVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/11.
//Copyright © 2020 ping. All rights reserved.
//

#import "PartyEliteDownloadVC.h"

@interface PartyEliteDownloadVC ()
@property (nonatomic, strong) UIImageView *iv;

@end

@implementation PartyEliteDownloadVC
- (UIImageView *)iv{
    if (!_iv) {
        UIImageView * iv = [UIImageView new];
           iv.backgroundColor = [UIColor clearColor];
           iv.contentMode = UIViewContentModeScaleAspectFill;
           iv.clipsToBounds = true;
           iv.image = [UIImage imageNamed:@"partyCommitment"];
           iv.widthHeight = XY(SCREEN_WIDTH,2245.0/1587.0*SCREEN_WIDTH);
        _iv = iv;
    }
    return _iv;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
   
    self.tableView.tableHeaderView = self.iv;
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackTitle:@"" rightTitle:@"下载" rightBlock:^{
        [weakSelf saveImage];
    }]];
}
- (void)saveImage{
    UIImage * qrImage = [UIImage captureImageFromView:self.tableView];
           [GlobalMethod fetchPhotoAuthorityBlock:^{
               UIImageWriteToSavedPhotosAlbum(qrImage, self, @selector(image: didFinishSavingWithError:contextInfo:), nil);
           }];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [GlobalMethod showAlert:[NSString stringWithFormat:@"写入相册失败%@",error]];
    } else {
        [GlobalMethod showAlert:@"写入相册成功"];
    }
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
//table footer
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

#pragma mark request
- (void)requestList{
    
}
@end
