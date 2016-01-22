//
//  GoodsCell.h
//  iShopping
//
//  Created by Siren on 15/10/9.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WikiRowsModel.h"
@interface GoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *referrer;
@property (weak, nonatomic) IBOutlet UILabel *reason;
@property (weak, nonatomic) IBOutlet UILabel *recommend;
@property (weak, nonatomic) IBOutlet UILabel *collect;
@property (weak, nonatomic) IBOutlet UILabel *comment;


-(void)setUIWithInfo:(WikiRowsModel *)model;
@end
