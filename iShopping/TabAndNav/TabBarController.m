//
//  TabBarController.m
//  iShopping
//
//  Created by Siren on 15/10/8.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.tabBar.tintColor = [UIColor redColor];
   
    NSArray *names = @[@"首页",@"商品",@"推荐",@"关于"];
    NSArray *img = @[@"mainNormal",@"goodsNormal",@"dingyueItemNormal",@"personNormal"];
    NSArray *selectedImg = @[@"mainSeleted",@"goodsseleted",@"dingyueItemSelected",@"personSeleted"];
    for (int i=0; i<4; i++) {
        UINavigationController *nav = self.viewControllers[i];
        UIViewController *vc = nav.viewControllers[0];
        UIImage *image = [UIImage imageNamed:img[i]];
        UIImage *selectedImage = [UIImage imageNamed:selectedImg[i]];
        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:names[i] image:image selectedImage:selectedImage];
        
    }
}

//+(UIImage *)renderingImage:(NSString *)originalImageName{
//    UIImage *img = [UIImage imageNamed:originalImageName];
//    return [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
