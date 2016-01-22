//
//  WebViewController.m
//  iShopping
//
//  Created by Siren on 15/10/9.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "WebViewController.h"
@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];
    
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    self.webView.scalesPageToFit = YES;
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setImage:[UIImage imageNamed:@"fx2"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shareToSocialNetWork) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barBtn;
    
}

-(void)shareToSocialNetWork{

    NSString *text = [NSString stringWithFormat:@"%@%@",_rowsMod.article_title,_rowsMod.article_url];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_rowsMod.article_pic]];
    UIImage *image = [UIImage imageWithData:data];
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"562b3200e0f55aead40011cd" shareText:text shareImage:image shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina, UMShareToFacebook, UMShareToTwitter, UMShareToWechatFavorite, UMShareToWechatSession, UMShareToWechatTimeline, UMShareToQQ, UMShareToQzone, nil] delegate:nil];
    [UMSocialData defaultData].extConfig.qqData.url = _rowsMod.article_url;
    [UMSocialData defaultData].extConfig.qzoneData.url = _rowsMod.article_url;
    
//    [UMSocialData defaultData].extConfig.qqData.title = @"QQ分享title";
//    [UMSocialData defaultData].extConfig.qzoneData.title = @"Qzone分享title";
}



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
