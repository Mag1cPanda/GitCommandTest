//
//  GoodDetailViewController.h
//  iShopping
//
//  Created by Siren on 15/10/14.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *detailPic;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (copy, nonatomic) NSString *picUrl;
@property (copy, nonatomic) NSString *detail;

@end
