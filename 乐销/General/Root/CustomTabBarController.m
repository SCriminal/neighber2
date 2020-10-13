//
//  BPViewController.m
//  家有宝贝
//
//  Created by wuli萍萍 on 16/5/21.
//  Copyright © 2016年 wuli萍萍. All rights reserved.
//

#import "CustomTabBarController.h"
#import "CustomTabBar.h"
#import "WhistleTabVC.h"
@interface CustomTabBarController ()
@property (nonatomic, strong) UIButton *btnWhistle;
@property (nonatomic, strong) UIImageView *shadow;

@end

@implementation CustomTabBarController
#pragma mark 懒加载
- (UIImageView *)shadow{
    if (!_shadow) {
        _shadow = [UIImageView new];
        _shadow.widthHeight = XY(SCREEN_WIDTH, W(15));
        _shadow.backgroundColor = [UIColor clearColor];
        _shadow.image = [UIImage imageNamed:@"tab_shadow"];
        _shadow.bottom = 0;
    }
    return _shadow;
}
- (UIButton *)btnWhistle{
    if (_btnWhistle == nil) {
        _btnWhistle = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWhistle.tag = 108;
        [_btnWhistle addTarget:self action:@selector(whistleClick) forControlEvents:UIControlEventTouchUpInside];
        _btnWhistle.backgroundColor = [UIColor clearColor];
        _btnWhistle.widthHeight = XY(W(44),W(44));
        [_btnWhistle setImage:[UIImage imageNamed:@"tab_whistle"] forState:UIControlStateNormal];
        _btnWhistle.centerXTop = XY(SCREEN_WIDTH/2.0, -W(18));
    }
    return _btnWhistle;
}
#pragma mark view appear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //去掉分割线
    GB_Nav.navigationBar.shadowImage = [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self.view setBackgroundColor:COLOR_BACKGROUND];
    // 添加子控制器
    [self setUpChildVC:[NSClassFromString(@"CommunityVC") new] title:@"社区" image:@"tab_community_default" selectedImage:@"tab_community_selected"];
    [self setUpChildVC:[NSClassFromString(@"LifeVC") new] title:@"生活" image:@"tab_life_default" selectedImage:@"tab_life_selected"];
    [self setUpChildVC:[NSClassFromString(@"WhistleTabVC") new] title:@"小红哨" image:@"" selectedImage:@""];
    
    [self setUpChildVC:[NSClassFromString(@"ShoppingVC") new] title:@"购物" image:@"tab_shopping_default" selectedImage:@"tab_shopping_selected"];
    [self setUpChildVC:[NSClassFromString(@"PerCenterVC") new] title:@"我的" image:@"tab_mine_default" selectedImage:@"tab_mine_selected"];
        
    CustomTabBar *tabBar = [[CustomTabBar alloc] init];
    //针对ios13 进行设置
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [tabBar.standardAppearance copy];
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = @{NSForegroundColorAttributeName : COLOR_ORANGE ,NSFontAttributeName:[UIFont systemFontOfSize:F(10)]};
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = @{NSForegroundColorAttributeName :  [UIColor colorWithHexString:@"757F84"],NSFontAttributeName:[UIFont systemFontOfSize:F(10)]};
        appearance.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 1)];
        appearance.shadowColor = [UIColor whiteColor];
        tabBar.standardAppearance = appearance;
    } else {
        [[CustomTabBar appearance]setBackgroundColor:[UIColor whiteColor]];
        [[CustomTabBar appearance]setShadowImage:[UIImage new]];//将TabBar上的黑线去掉
        [[CustomTabBar appearance]setBackgroundImage:[UIImage new]];
    }
    [tabBar addSubview:self.shadow];
    [tabBar addSubview:self.btnWhistle];
    // 设置代理
    tabBar.delegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
    self.tabBar.opaque = YES;
}


#pragma mark ---- 初始化子控制器
- (void)setUpChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    vc.title = title;
    
    vc.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 禁用图片渲染
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置字体和图片的距离
    [self configTabbarImageAndTitle:vc];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    [self addChildViewController:vc];
}

- (void)configTabbarImageAndTitle:(UIViewController *)vc{
    // 设置文字的样式
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName :  [UIColor colorWithHexString:@"757F84"],NSFontAttributeName:[UIFont systemFontOfSize:F(10)]} forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : COLOR_ORANGE ,NSFontAttributeName:[UIFont systemFontOfSize:F(10)]} forState:UIControlStateSelected];

    //设置字体和图片的距离
    CGFloat spaceTop;
    CGFloat imageTop;
    CGFloat fontSize;
    if (SCREEN_WIDTH == 320) {
        imageTop = -2;
        fontSize = 9;
        spaceTop = -8;
    }else if (SCREEN_WIDTH == 375){
        imageTop = -2;
        fontSize = 11;
        spaceTop = -5;
    }else if (SCREEN_WIDTH == 414){
        imageTop = -2;
        fontSize = 12;
        spaceTop = -9;
    }else{
        imageTop = -2;
        fontSize = 11;
        spaceTop = -9;
    }
    [vc.tabBarItem setImageInsets:UIEdgeInsetsMake(imageTop,0, -imageTop, 0)];
        
    [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, spaceTop-2)];
    
    
    
}

- (void)viewWillLayoutSubviews
{
    CGFloat tabberHeight = TABBAR_HEIGHT;
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = tabberHeight;
    tabFrame.origin.y = self.view.frame.size.height - tabberHeight;
    self.tabBar.frame = tabFrame;
}

#pragma mark tabbarVC delegate
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:WhistleTabVC.class]) {
        [self whistleClick];
        return false;
    }
    return true;
}
#pragma mark click
- (void)whistleClick{
    [GlobalMethod judgeLoginState:^{
        [GB_Nav pushVCName:@"WhistleTabVC" animated:true];
        
    }];
}


@end
