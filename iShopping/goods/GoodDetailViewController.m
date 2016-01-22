//
//  GoodDetailViewController.m
//  iShopping
//
//  Created by Siren on 15/10/14.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "GoodDetailViewController.h"
#import "UMSocial.h"
@interface GoodDetailViewController ()

@end

@implementation GoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.detailPic setImageWithURL:[NSURL URLWithString:self.picUrl]];
    if ([self.detail isEqualToString:@""]) {
        self.detailLab.text = @"亲，此款商品没有详情描述哦~😳";
    } else {
        self.detailLab.text = self.detail;
    }
//    self.hidesBottomBarWhenPushed = YES;
    
    
    [self.detailLab sizeToFit];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"562b3200e0f55aead40011cd" shareText:@"" shareImage:[UIImage imageNamed:@"shigong"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToFacebook,UMShareToTwitter,UMShareToSms,UMShareToWechatFavorite,UMShareToWechatSession,UMShareToWechatTimeline, nil] delegate:nil];
    
}

//
//-(void)did

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
